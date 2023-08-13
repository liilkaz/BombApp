//
//  CategoryQuests.swift
//  Bomb
//
//  Created by Илья Шаповалов on 12.08.2023.
//

import Foundation

struct CategoryQuests: Codable {
    let category: CategoryName
    let questions: [String]
    
    static let sample: [CategoryQuests] = [
        .init(category: .art, questions: ["Some one", "Some two", "Some three"]),
        .init(category: .celebrity, questions: ["Some one", "Some two", "Some three"]),
        .init(category: .life, questions: ["Some one", "Some two", "Some three"])
    ]
}
