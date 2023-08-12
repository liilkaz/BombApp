//
//  GameOverDomainTests.swift
//  BombTests
//
//  Created by Илья Шаповалов on 13.08.2023.
//

import XCTest
import Combine

@testable import Bomb

final class GameOverDomainTests: XCTestCase {
    private var sut: GameOverDomain!
    private var state: GameOverDomain.State!
    private var spy: Spy<GameOverDomain.Action>!
    private var testActions: [String]!
    
    override func setUp() async throws {
        try await super.setUp()
        
        testActions = ["Baz", "Bar"]
        sut = .init(loadActions: { [unowned self] in
            Just(testActions)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        })
        state = .init()
        spy = .init()
    }
    
    override func tearDown() async throws {
        sut = nil
        state = nil
        spy = nil
        testActions = nil
    }
    
    func test_viewAppearedEmitRequestAction() {
        spy.schedule(
            sut.reduce(&state, action: .viewAppeared)
        )
        
        XCTAssertEqual(spy.actions.first, .actionsRequest)
    }
    
    func test_requestQuestsEndWithSuccess() {
        sut = .init(randomNumber: {_ in 1 })
        
        _ = sut.reduce(&state, action: .actionsResponse(.success(testActions)))
        
        XCTAssertEqual(state.quest, testActions[1])
        XCTAssertEqual(state.questsArray, testActions)
    }
    
    func test_requestQuestsEndWithError() {
        let testError: Error = URLError(.badURL)
        
        _ = sut.reduce(&state, action: .actionsResponse(.failure(testError)))
        
        XCTAssertEqual(state.quest, testError.localizedDescription)
    }
    
    func test_anotherPunishmentButtonTap() {
        sut = .init(randomNumber: {_ in 1 })
        state.quest = "Baz"
        state.questsArray = ["Baz", "Bar"]
        
        _ = sut.reduce(&state, action: .anotherPunishmentButtonTap)
        
        XCTAssertEqual(state.quest, "Bar")
    }
}
