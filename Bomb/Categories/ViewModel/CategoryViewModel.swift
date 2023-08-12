//
//  CategoryViewModel.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import Foundation
import Combine

final class CategoryViewModel: ObservableObject {
    
    @Published var categories = [Category]()
    @Published var questions = [String]()
    
    init() {
        categories = CategoryData.shared.questions
    }
    
    func save() -> [CategoryName] {
         categories.filter(\.isSelected).map(\.name)
    }
    
    func getCategories(names: [CategoryName]) {
        categories = categories.map { category in
            var chosen = category
            chosen.isSelected = names.contains(category.name) ? true : false
            return chosen
        }
    }
}
