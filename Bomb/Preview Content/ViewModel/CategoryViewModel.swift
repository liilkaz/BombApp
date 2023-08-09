//
//  CategoryViewModel.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import Foundation

final class CategoryViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    @Published var questions: [String] = []
    
    init() {
        categories = [
            Category(name: .varied, questions: ["О Разном?"], isSelected: false),
            Category(name: .sport, questions: ["Спорт и Хобби?"], isSelected: false),
            Category(name: .life, questions: ["Про жизнь?"], isSelected: false),
            Category(name: .celebrity, questions: ["Знаменитости?"], isSelected: false),
            Category(name: .art, questions: ["Искусство и Кино?"], isSelected: false),
            Category(name: .nature, questions: ["Природа?"], isSelected: false)
        ]
    }
    
    func getQuestions() {
        questions = categories.filter{ $0.isSelected }.flatMap{ $0.questions }
    }
    
}
