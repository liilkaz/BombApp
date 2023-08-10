//
//  DataProvider.swift
//  Bomb
//
//  Created by Илья Шаповалов on 10.08.2023.
//

import Foundation

final class DataProvider: ObservableObject {
    private struct Keys {
        static let gameState = "GameState"
        static let categories = "categories"
        static let settings = "GameSettings"
    }
    
    enum DataError: Error {
        case notFound
        case typeMismatch
    }
    
    private let userDefaults: UserDefaults
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        
        self.decoder = JSONDecoder()
        self.encoder = JSONEncoder()
    }
    
    func save(categories: [CategoryName]) throws {
        let data = try encoder.encode(categories)
        userDefaults.setValue(data, forKey: Keys.categories)
    }
    
    func loadCategories() throws -> [CategoryName] {
        guard let data = userDefaults.data(forKey: Keys.categories) else {
            throw DataError.notFound
        }
        return try decoder.decode([CategoryName].self, from: data)
    }
}
