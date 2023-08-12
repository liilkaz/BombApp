//
//  AppFileManager.swift
//  Bomb
//
//  Created by Илья Шаповалов on 12.08.2023.
//

import Foundation
import Combine

struct AppFileManager {
    var loadQuestions: (CategoryName) -> AnyPublisher<CategoryQuests, Error>
    var loadQuests: () -> AnyPublisher<[String], Error>
    
    static let live = Self { categoryName in
        Bundle.main
            .url(forResource: "CategoryQuestions", withExtension: "json")
            .publisher
            .tryMap { try Data(contentsOf: $0) }
            .decode(type: [CategoryQuests].self, decoder: JSONDecoder())
            .compactMap{ categories in
                categories.first(where: { $0.category == categoryName })
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
        Just(CategoryQuests.sample[0])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    } loadQuests: {
        Just(["Test1", "Test2"])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
