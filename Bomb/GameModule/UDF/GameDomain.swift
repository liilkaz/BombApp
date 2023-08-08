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
        var title: String
        var counter: Int
        var gameState: GameFlow
        
        init(
            title: String = .init(),
            counter: Int = .init(),
            gameState: GameFlow = .initial
        ) {
            self.title = title
            self.counter = counter
            self.gameState = gameState
        }
    }
    
    //MARK: - Action
    enum Action: Equatable {
        case viewAppeared
        case setupGame
        case launchButtonTap
        case pauseButtonTap
        case timerTicked
        case gameOver
        case playAgainButtonTap
    }
    
    //MARK: - Dependencies
    private let timerService: TimerProtocol
    private let player: AudioPlayerProtocol
    
    //MARK: - init(_:)
    init(
        timerService: TimerProtocol = TimerService(),
        player: AudioPlayerProtocol = AudioPlayer()
    ) {
        self.timerService = timerService
        self.player = player
        
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
                Just(Action.setupGame)
            )
            .eraseToAnyPublisher()
            
        case .setupGame:
            state.gameState = .initial
            state.title = "Нажмите запустить, чтобы начать игру"
            
        case .launchButtonTap:
            state.gameState = .play
            player.playTicking()
            timerService.startTimer()
            
        case .pauseButtonTap:
            player.stop()
            timerService.stopTimer()
            
        case .timerTicked:
            guard state.counter < 30 else {
                player.playBlow()
                return Just(.gameOver).eraseToAnyPublisher()
            }
            state.counter += 1
            
        case .gameOver:
            state.gameState = .gameOver
            state.title = "Конец игры"
            
        case .playAgainButtonTap:
            return Just(.setupGame).eraseToAnyPublisher()
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
