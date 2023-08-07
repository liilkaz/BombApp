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
        
    }
    
    //MARK: - init(_:)
    init() {}
    
    //MARK: - Reducer
    func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        
        return Empty().eraseToAnyPublisher()
    }
    
    //MARK: - Preview store
 //   static let previewStore
    
    //MARK: - Live store
}
