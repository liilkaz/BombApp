//
//  CategoryData.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 10.08.2023.
//

import Foundation

class CategoryData {
    
    static let questions: [Category] = [
        Category(name: .varied, questions: ["О Разном?"], isSelected: true),
        Category(name: .sport, questions: ["Спорт и Хобби?"], isSelected: false),
        Category(name: .life, questions: ["Про жизнь?"], isSelected: false),
        Category(name: .celebrity, questions: ["Знаменитости?"], isSelected: false),
        Category(name: .art, questions: ["Искусство и Кино?"], isSelected: false),
        Category(name: .nature, questions: ["Природа?"], isSelected: false)
    ]
}
