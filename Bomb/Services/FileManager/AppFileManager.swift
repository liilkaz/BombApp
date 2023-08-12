//
//  AppFileManager.swift
//  Bomb
//
//  Created by Илья Шаповалов on 12.08.2023.
//

import Foundation
import Combine

struct AppFileManager {
    var loadQuestions: ([CategoryName]) -> AnyPublisher<[CategoryQuests], Error>
    var loadQuests: () -> AnyPublisher<[String], Error>
    
    static let live = Self { categoryNames in
        Bundle.main
            .url(forResource: "CategoryQuestions", withExtension: "json")
            .publisher
            .tryMap { try Data(contentsOf: $0) }
            .decode(type: [CategoryQuests].self, decoder: JSONDecoder())
            .compactMap{ categories in
                categories.filter{ categoryNames.contains($0.category) }
            }
            .eraseToAnyPublisher()
    } loadQuests: {
        Bundle.main
            .url(forResource: "actions", withExtension: "txt")
            .publisher
            .tryMap { try String(contentsOf: $0) }
            .map{ $0.components(separatedBy: "\n") }
            .eraseToAnyPublisher()
    }
    
    static let preview = Self {_ in 
        Just(CategoryQuests.sample)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    } loadQuests: {
        Just(["Test1", "Test2"])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
