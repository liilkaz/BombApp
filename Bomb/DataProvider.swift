//
//  DataProvider.swift
//  Bomb
//
//  Created by Илья Шаповалов on 10.08.2023.
//

import Foundation
import OSLog
import Combine

final class DataProvider: ObservableObject {
    private struct Keys {
        static let gameState = "GameState"
        static let categories = "categories"
        static let settings = "GameSettings"
    }
    
    enum DataError: Error {
        case notFound(String)
        case typeMismatch
    }
    
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: DataProvider.self)
    )
    
    private let userDefaults: UserDefaults
    private let decoder: JSONDecoder
    private var cancellable: Set<AnyCancellable> = .init()
    
    @Published private var categories: [CategoryName] = .init()
    @Published private var settings: Settings = .init()
    @Published private var gameState: GameDomain.State = .init()
    
    //MARK: - init(_:)
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.decoder = JSONDecoder()
        
        logger.debug("initialized")
        
        do {
            categories = try loadValue(forKey: Keys.categories)
            gameState = try loadValue(forKey: Keys.gameState)
            settings = try loadValue(forKey: Keys.settings)
        } catch {
            logger.error("Unable to load data: \(error.localizedDescription)")
        }
        
        self.saveValue(
            for: self.$categories,
            withKey: Keys.categories
        )
        .store(in: &cancellable)
        
        self.saveValue(
            for: self.$gameState,
            withKey: Keys.gameState
        )
        .store(in: &cancellable)
        
        self.saveValue(
            for: self.$settings,
            withKey: Keys.settings
        )
        .store(in: &cancellable)
    }
}

private extension DataProvider {
    //MARK: - Private methods
    func loadValue<T: Decodable>(forKey key: String) throws -> T {
        guard let data = userDefaults.data(forKey: key) else {
            throw DataError.notFound(key)
        }
        return try decoder.decode(T.self, from: data)
    }
    
    func saveValue<V>(
        for publisher: Published<V>.Publisher,
        withKey key: String
    ) -> AnyCancellable where V: Encodable, V: Equatable {
        publisher
            .removeDuplicates()
            .encode(encoder: JSONEncoder())
            .sink(
                receiveCompletion: { self.logger.debug("Completion: \(String(reflecting: $0))") },
                receiveValue: { self.userDefaults.setValue($0, forKey: key) }
            )
    }
}
