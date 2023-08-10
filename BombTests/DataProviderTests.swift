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
    
    

}

final class MockDefaults: UserDefaults {
    private(set) var isDataRequested = false
    private(set) var requestedKey = String()
    
    override func data(forKey defaultName: String) -> Data? {
        return nil
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        requestedKey = defaultName
    }
}
