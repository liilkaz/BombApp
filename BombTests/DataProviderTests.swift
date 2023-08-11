//
//  DataProviderTests.swift
//  BombTests
//
//  Created by Илья Шаповалов on 11.08.2023.
//

import XCTest
import Combine

@testable import Bomb

final class DataProviderTests: XCTestCase {
    private var sut: DataProvider!
    private var mockDefaults: MockDefaults!
    
    override func setUp() async throws {
        try await super.setUp()
        
        mockDefaults = .init()
        sut = .init(userDefaults: mockDefaults)
    }
    
    override func tearDown() async throws {
        mockDefaults = nil
        sut = nil
    }

    func test_sutContainsError() {
        XCTAssertTrue(mockDefaults.isDataRequested)
        XCTAssertNotNil(sut.error)
    }
    
    func test_sutSaveCategoryOnChange() {
        let testCategory = CategoryName.art
        
        sut.categories.append(testCategory)
        
        XCTAssertEqual(mockDefaults.requestedKey, "categories")
    }
    
    func test_sutSaveSettingsOnChange() {
        let testSettings = Settings()
        
        sut.settings = testSettings
        
        XCTAssertEqual(mockDefaults.requestedKey, "GameSettings")
    }
    
    func test_sutSaveGameStateOnChange() {
        let testState = GameDomain.State(gameFlow: .gameOver)
        
        sut.gameState = testState
        
        XCTAssertEqual(mockDefaults.requestedKey, "GameState")
    }
}

final class MockDefaults: UserDefaults {
    private(set) var isDataRequested = false
    private(set) var requestedKey = String()
    
    override func data(forKey defaultName: String) -> Data? {
        isDataRequested = true
        return nil
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        requestedKey = defaultName
    }
}
