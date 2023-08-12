//
//  CategoryData.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 10.08.2023.
//

import Foundation

struct CategoryData {
    
    static var shared = CategoryData()
    
    private init() {}
    
    lazy var questions: [Category] = [
        Category(name: .varied, isSelected: true),
        Category(name: .sport, isSelected: false),
        Category(name: .life, isSelected: false),
        Category(name: .celebrity, isSelected: false),
        Category(name: .art, isSelected: false),
        Category(name: .nature, isSelected: false)
    ]
}
