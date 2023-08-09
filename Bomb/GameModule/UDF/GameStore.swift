//
//  GameStore.swift
//  Bomb
//
//  Created by Илья Шаповалов on 07.08.2023.
//

import Foundation
import OSLog
import Combine

@dynamicMemberLookup
final class GameStore: ObservableObject {
    //MARK: - Private properties
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: GameStore.self)
    )
    private var cancellable: Set<AnyCancellable> = .init()
    private let reducer: GameDomain
    
    //MARK: - State property
    @Published private(set) var state: GameDomain.State
    
    //MARK: - init(_:)
    init(
        initialState: GameDomain.State,
        reducer: GameDomain
    ) {
        self.state = initialState
        self.reducer = reducer
        logger.debug("Initialized")
        
        $state
            .map(String.init(reflecting:))
            .sink(receiveValue: logState)
            .store(in: &cancellable)
    }
    
    deinit {
        logger.debug("Deinitialised")
    }
    
    //MARK: - Send
    @inlinable
    func send(_ action: GameDomain.Action) {
        reducer.reduce(&state, action: action)
            .receive(on: DispatchQueue.main)
            .map(logAction)
            .sink(receiveValue: send)
            .store(in: &cancellable)
    }
    
    //MARK: - subscript
    subscript<T>(dynamicMember keyPath: KeyPath<GameDomain.State, T>) -> T {
        state[keyPath: keyPath]
    }
}

private extension GameStore {
    func logState(_ state: String) {
        logger.debug("\(state)")
    }
    
    func logAction(_ action: GameDomain.Action) -> GameDomain.Action {
        logger.debug("\(String(reflecting: action))")
        return action
    }
}