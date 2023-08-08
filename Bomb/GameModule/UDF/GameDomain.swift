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
            return Publishers.Merge(
                timerService
                    .timerTick
                    .map { _ in Action.timerTicked },
                Just(GameFlow.initial)
                    .map(Action.gameState)
            )
            .eraseToAnyPublisher()
            
        case .gameState(.initial):
            state.gameFlow = .initial
            state.title = "Нажмите запустить, чтобы начать игру"
            
        case .gameState(.play):
            state.gameFlow = .initial
            player.playTicking()
            timerService.startTimer()
            
        case .gameState(.pause):
            state.gameFlow = .pause
            player.stop()
            timerService.stopTimer()
            
        case .gameState(.gameOver):
            state.gameFlow = .gameOver
            timerService.stopTimer()
            player.playBlow()
            state.title = "Конец игры"
            let randomIndex = randomNumber(state.punishmentArr.count)
            state.punishment = state.punishmentArr[randomIndex]
            
        case .timerTicked:
            guard state.counter < 30 else {
                return Just(.gameState(.gameOver))
                    .eraseToAnyPublisher()
            }
            state.counter += 1
            
        case .launchButtonTap:
            return Just(.gameState(.play))
                .eraseToAnyPublisher()
            
        case .pauseButtonTap:
            return Just(.gameState(.pause))
                .eraseToAnyPublisher()
            
        case .playAgainButtonTap:
            return Just(.gameState(.initial))
                .eraseToAnyPublisher()
            
        case .anotherPunishmentButtonTap:
            let randomIndex = randomNumber(state.punishmentArr.count)
            state.punishment = state.punishmentArr[randomIndex]
        }
        
        return Empty().eraseToAnyPublisher()
    }
    
    //MARK: - Preview store
    static let previewStore = GameStore(
        initialState: Self.State(),
        reducer: Self()
    )
    
    //MARK: - Live store
}
