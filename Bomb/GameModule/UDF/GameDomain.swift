//
//  GameDomain.swift
//  Bomb
//
//  Created by Илья Шаповалов on 07.08.2023.
//

import Foundation
import Combine
import OSLog

struct GameDomain {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    //MARK: - State
    struct State: Equatable {
        var title: String = .init()
        var punishment: String = .init()
        var punishmentArr: [String] = .init()
        var counter: Int = .init()
        var gameFlow: GameFlow = .initial
    }
    
    //MARK: - Action
    enum Action: Equatable {
        case viewAppeared
        case gameState(GameFlow)
        case launchButtonTap
        case pauseButtonTap
        case timerTicked
        case playAgainButtonTap
        case anotherPunishmentButtonTap
    }
    
    //MARK: - Dependencies
    private let timerService: TimerProtocol
    private let player: AudioPlayerProtocol
    private let randomNumber: (Int) -> Int
    
    //MARK: - init(_:)
    init(
        timerService: TimerProtocol = TimerService(),
        player: AudioPlayerProtocol = AudioPlayer(),
        randomNumber: @escaping (Int) -> Int = { Int.random(in: 0...$0) }
    ) {
        self.timerService = timerService
        self.player = player
        self.randomNumber = randomNumber
        
        logger.debug("Initialized")
    }
    
    //MARK: - Reducer
    func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case .viewAppeared:
            logger.debug("View appeared")
            return Publishers.Merge(
                timerService
                    .timerTick
                    .map { _ in Action.timerTicked },
                Just(GameFlow.initial)
                    .map(Action.gameState)
            )
            .eraseToAnyPublisher()
            
        case .gameState(.initial):
            logger.debug("Setup game state to initial")
            state.gameFlow = .initial
            state.title = "Нажмите запустить, чтобы начать игру"
            
        case .gameState(.play):
            logger.debug("Setup game state to play")
            state.gameFlow = .initial
            player.playTicking()
            timerService.startTimer()
            
        case .gameState(.pause):
            logger.debug("Setup game state to pause")
            state.gameFlow = .pause
            player.stop()
            timerService.stopTimer()
            
        case .gameState(.gameOver):
            logger.debug("Setup game state to gameOver")
            state.gameFlow = .gameOver
            timerService.stopTimer()
            player.playBlow()
            state.title = "Конец игры"
            state.punishment = getRandomElement(from: state.punishmentArr)
            
        case .timerTicked:
            guard state.counter < 30 else {
                logger.debug("Send action to switch state to gameOver")
                return Just(.gameState(.gameOver))
                    .eraseToAnyPublisher()
            }
            state.counter += 1
            
        case .launchButtonTap:
            logger.debug("Send action to switch state to play")
            return Just(.gameState(.play))
                .eraseToAnyPublisher()
            
        case .pauseButtonTap:
            switch state.gameFlow {
            case .pause:
                logger.debug("Send action to switch state to play")
                return Just(.gameState(.play))
                    .eraseToAnyPublisher()
            default:
                logger.debug("Send action to switch state to pause")
                return Just(.gameState(.pause))
                    .eraseToAnyPublisher()
            }
            
        case .playAgainButtonTap:
            logger.debug("Send action to switch state to initial")
            return Just(.gameState(.initial))
                .eraseToAnyPublisher()
            
        case .anotherPunishmentButtonTap:
            state.punishment = getRandomElement(from: state.punishmentArr)
        }
        
        return Empty().eraseToAnyPublisher()
    }
    
    //MARK: - Live store
    static let liveStore = GameStore(
        initialState: Self.State(),
        reducer: Self()
    )
    
    //MARK: - Preview stores
    static let previewStoreInitialState = GameStore(
        initialState: Self.State(gameFlow: .initial),
        reducer: Self()
    )
    
    static let previewStorePlayState = GameStore(
        initialState: Self.State(gameFlow: .play),
        reducer: Self()
    )
    
    static let previewStorePauseState = GameStore(
        initialState: Self.State(gameFlow: .pause),
        reducer: Self()
    )
    
    static let previewStoreGameOverState = GameStore(
        initialState: Self.State(gameFlow: .gameOver),
        reducer: Self()
    )
}

private extension GameDomain {
    func getRandomElement(from collection: [String]) -> String {
        let randomIndex = randomNumber(collection.count)
        return collection[randomIndex]
    }
}
