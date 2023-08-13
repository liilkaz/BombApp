//
//  GameStore.swift
//  Bomb
//
//  Created by Илья Шаповалов on 07.08.2023.
//

import Foundation
import OSLog
import Combine

typealias StoreOf<R: ReducerProtocol> = Store<R.State, R.Action>

@dynamicMemberLookup
final class Store<State, Action>: ObservableObject {
    //MARK: - Private properties
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "Store"
    )
    private var cancellable: Set<AnyCancellable> = .init()
    private let reducer: any ReducerProtocol<State, Action>
    
    //MARK: - State property
    @Published private(set) var state: State
    
    //MARK: - init(_:)
    init<R: ReducerProtocol>(
        initialState: R.State,
        reducer: R
    ) where R.State == State, R.Action == Action {
        self.state = initialState
        self.reducer = reducer
        logger.debug("Initialized")
    }
    
    deinit {
        logger.debug("Deinitialised")
    }
    
    //MARK: - Send
    @inlinable
    func send(_ action: Action) {
        reducer.reduce(&state, action: action)
            .receive(on: DispatchQueue.main)
            .map(logAction)
            .sink(receiveValue: send)
            .store(in: &cancellable)
    }
    
    func dispose() {
        cancellable.removeAll()
        logger.debug("Store disposed all cancellable.")
    }
    
    //MARK: - subscript
    subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
        state[keyPath: keyPath]
    }
    
    func logState() -> Self {
        self.$state
            .map(String.init(reflecting:))
            .sink { [weak self] in self?.logger.debug("\($0)") }
            .store(in: &self.cancellable)
        
        return self
    }
}

private extension Store {
    func logState(_ state: String) {
        logger.debug("\(state)")
    }
    
    func logAction(_ action: Action) -> Action {
        logger.debug("\(String(reflecting: action))")
        return action
    }
}
