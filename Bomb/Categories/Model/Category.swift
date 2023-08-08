//
//  Category.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import Foundation

struct Category: Identifiable {
    var id = UUID()
    let name: CategoryName
    let questions: [String]
    var isSelect: Bool
}

enum CategoryName: String {
    case art = "Искусство и кино"
    case celebrity = "Знаменитости"
    case life = "Про жизнь"
    case nature = "Природа"
    case sport = "Спорт и Хобби"
    case varied = "О Разном"
}
