//
//  GameOverDomain.swift
//  Bomb
//
//  Created by Илья Шаповалов on 13.08.2023.
//

import Foundation
import Combine
import OSLog

struct GameOverDomain: ReducerProtocol {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    //MARK: - State
    struct State {
        var quest: String = .init()
        var questsArray: [String] = .init()
    }
    
    //MARK: - Action
    enum Action: Equatable {
        case viewAppeared
        case actionsRequest
        case actionsResponse(Result<[String], Error>)
        case anotherPunishmentButtonTap
        
        static func == (lhs: GameOverDomain.Action, rhs: GameOverDomain.Action) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
    
    //MARK: - Dependencies
    private let loadActions: () -> AnyPublisher<[String],Error>
    private let randomNumber: (Int) -> Int
    
    //MARK: - init(_:)
    init(
        randomNumber: @escaping (Int) -> Int = { Int.random(in: 0..<$0) },
        loadActions: @escaping () -> AnyPublisher<[String], Error> = AppFileManager.live.loadQuests
    ) {
        self.loadActions = loadActions
        self.randomNumber = randomNumber
    }
    
    //MARK: - Reducer
    func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case .viewAppeared:
            logger.debug("View appeared")
            return Just(.actionsRequest)
                .eraseToAnyPublisher()
            
        case .actionsRequest:
            logger.debug("Requesting actions.")
            return loadActions()
                .map(transformToSuccessAction)
                .catch(catchToFailAction)
                .eraseToAnyPublisher()
            
        case let .actionsResponse(.success(quests)):
            logger.debug("Request actions end with success. Loaded: \(quests.count.description) actions.")
            state.questsArray = quests
            state.quest = getRandomElement(from: quests)
            
        case let .actionsResponse(.failure(error)):
            logger.error("Fail to load actions: \(error.localizedDescription)")
            state.quest = error.localizedDescription
            
        case .anotherPunishmentButtonTap:
            logger.debug("Set another action.")
            state.quest = getRandomElement(from: state.questsArray)
       
        }
        return Empty().eraseToAnyPublisher()
    }
    
    //MARK: - previewStore
    static let previewStore = Store(
        initialState: Self.State(),
        reducer: Self(loadActions: {
            Just(["Who are you?", "Fuck off."])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        })
    )
    
    static let liveStore = Store(
        initialState: Self.State(),
        reducer: Self()
    )
}

private extension GameOverDomain {
    func transformToSuccessAction(_ quests: [String]) -> Action {
        .actionsResponse(.success(quests))
    }
    
    func catchToFailAction(_ error: Error) -> Just<Action> {
        Just(Action.actionsResponse(.failure(error)))
    }
    
    func getRandomElement(from collection: [String]) -> String {
        let randomIndex = randomNumber(collection.count)
        return collection[randomIndex]
    }
}
