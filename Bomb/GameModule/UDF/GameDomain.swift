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
        case launchButtonTap
        case timerTicked
        case gameOver
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
            state.gameState = .initial
            state.title = "Нажмите запустить, чтобы начать игру"
            
            return timerService
                .timerTick
                .map { _ in .timerTicked }
                .eraseToAnyPublisher()
            
        case .launchButtonTap:
            state.gameState = .play
            player.play()
            timerService.startTimer()
            
        case .timerTicked:
            guard state.counter < 30 else {
                return Just(.gameOver).eraseToAnyPublisher()
            }
            state.counter += 1
            
        case .gameOver:
            break
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
