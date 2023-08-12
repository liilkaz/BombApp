//
//  Category.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import Foundation

struct Category: Identifiable, Codable {
    let name: CategoryName
    var isSelected: Bool
    var id: String {
        name.rawValue
    }
}

enum CategoryName: String, CaseIterable, Codable {
    case art = "Искусство и кино"
    case celebrity = "Знаменитости"
    case life = "Про жизнь"
    case nature = "Природа"
    case sport = "Спорт и Хобби"
    case varied = "О Разном"
    
    var imageName: String {
        "\(self)"
    }
}
