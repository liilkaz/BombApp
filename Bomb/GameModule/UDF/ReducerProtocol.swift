//
//  ReducerProtocol.swift
//  Bomb
//
//  Created by Илья Шаповалов on 13.08.2023.
//

import Foundation
import Combine

protocol ReducerProtocol<State, Action> {
    associatedtype State//: Equatable
    associatedtype Action//: Equatable
    
    func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never>
}
