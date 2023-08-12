//
//  CategoryQuests.swift
//  Bomb
//
//  Created by Илья Шаповалов on 12.08.2023.
//

import Foundation

struct CategoryQuests: Codable {
    let category: CategoryName
    let quests: [String]
    
    init(category: CategoryName, quests: [String]) {
        self.category = category
        self.quests = quests
    }
    
    static let sample: [CategoryQuests] = [
        .init(category: .art, quests: ["Some one", "Some two", "Some three"]),
        .init(category: .celebrity, quests: ["Some one", "Some two", "Some three"]),
        .init(category: .life, quests: ["Some one", "Some two", "Some three"])
    ]
}
