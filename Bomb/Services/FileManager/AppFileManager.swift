//
//  AppFileManager.swift
//  Bomb
//
//  Created by Илья Шаповалов on 12.08.2023.
//

import Foundation
import Combine

struct AppFileManager {
    var loadQuestions: () -> AnyPublisher<[CategoryQuests], Error>
    
    static let live = Self {
        Bundle.main
            .url(forResource: "CategoryQuestions", withExtension: "json")
            .publisher
            .tryMap { try Data(contentsOf: $0) }
            .decode(type: [CategoryQuests].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static let preview = Self {
        Just(CategoryQuests.sample)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
