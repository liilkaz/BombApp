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
        
    }
    
    //MARK: - Action
    enum Action: Equatable {
        case viewAppeared
        case launchButtonTap
        case timerTicked
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
            return timerService
                .timerTick
                .map { _ in .timerTicked }
                .eraseToAnyPublisher()
            
        case .launchButtonTap:
            player.play()
            timerService.startTimer()
            
        case .timerTicked:
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
