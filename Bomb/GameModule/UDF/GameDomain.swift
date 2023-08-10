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
    struct State: Equatable, Codable {
        var title: String = .init()
        var punishment: String = .init()
        var punishmentArr: [String] = .init()
        var counter: Int = .init()
        var estimatedTime: Int = .init()
        var gameFlow: GameFlow = .init()
        var isShowSheet = false
    }
    
    //MARK: - Action
    enum Action: Equatable {
        case viewAppeared
        case viewDisappear
        case gameState(State.GameFlow)
        case launchButtonTap
        case pauseButtonTap
        case timerTick
        case playAgainButtonTap
        case anotherPunishmentButtonTap
        case dismissSheet
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
            
            guard state.gameFlow == .initial else {
                return timerService
                    .timerTick
                    .map { _ in .timerTick }
                    .eraseToAnyPublisher()
            }
            
            return timerService
                .timerTick
                .map { _ in .timerTick }
                .merge(with: Just(Action.gameState(.initial)))
                .eraseToAnyPublisher()
            
        case .viewDisappear:
            break
            
        case .gameState(.initial):
            logger.debug("Setup game state to initial")
            state.gameFlow = .initial
            state.counter = 0
            state.estimatedTime = 10
            state.isShowSheet = false
            state.punishmentArr = ["first", "second", "third"]
            state.title = "Нажмите запустить, чтобы начать игру"
            player.stop()
            
        case .gameState(.play):
            logger.debug("Setup game state to play")
            player.playTicking()
            player.playBackgroundMusic()
            timerService.startTimer()
            state.gameFlow = .play
            
        case .gameState(.pause):
            logger.debug("Setup game state to pause")
            player.stop()
            timerService.stopTimer()
            state.gameFlow = .pause
            state.title = "Пауза..."
            
        case .gameState(.gameOver):
            logger.debug("Setup game state to gameOver")
            timerService.stopTimer()
            player.playBlow()
            state.gameFlow = .gameOver
            state.title = "Конец игры"
            state.punishment = getRandomElement(from: state.punishmentArr)
            state.isShowSheet = true
            
        case .timerTick:
            guard state.counter < state.estimatedTime else {
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
            return Just(state)
                .map(\.gameFlow)
                .map(togglePause)
                .compactMap { $0 }
                .eraseToAnyPublisher()
            
        case .playAgainButtonTap:
            logger.debug("Send action to switch state to initial")
            return Just(.gameState(.initial))
                .eraseToAnyPublisher()
            
        case .anotherPunishmentButtonTap:
            state.punishment = getRandomElement(from: state.punishmentArr)
            
        case .dismissSheet:
            state.isShowSheet = false
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
        initialState: Self.State(
            title: "Нажмите запустить, чтобы начать игру",
            estimatedTime: 10,
            gameFlow: .initial
        ),
        reducer: Self()
    )
    
    static let previewStorePlayState = GameStore(
        initialState: Self.State(
            title: "Some question",
            gameFlow: .play
        ),
        reducer: Self()
    )
    
    static let previewStorePauseState = GameStore(
        initialState: Self.State(
            title: "Pause",
            gameFlow: .pause
        ),
        reducer: Self()
    )
    
    static let previewStoreGameOverState = GameStore(
        initialState: Self.State(
            title: "Конец игры",
            punishment: "В следующем раунде, после каждого ответа, хлопать в ладоши",
            gameFlow: .gameOver,
            isShowSheet: true
        ),
        reducer: Self()
    )
}

private extension GameDomain {
    func getRandomElement(from collection: [String]) -> String {
        let randomIndex = randomNumber(collection.count)
        return collection[randomIndex]
    }
    
    func togglePause(_ gameFlow: State.GameFlow) -> Action? {
        switch gameFlow {
        case .play:
            return .gameState(.pause)
        case .pause:
            return .gameState(.play)
        default:
            return nil
        }
    }
}

extension GameDomain.State {
    enum GameFlow: Codable {
        case initial
        case play
        case pause
        case gameOver
        
        init() {
            self = .initial
        }
    }
}
