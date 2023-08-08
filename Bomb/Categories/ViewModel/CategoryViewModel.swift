//
//  CategoryViewModel.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import Foundation

class CategoryViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    @Published var questions: [String] = []
    
    init() {
        categories = [
            Category(name: .varied, questions: ["О Разном?"], isSelect: false),
            Category(name: .sport, questions: ["Спорт и Хобби?"], isSelect: false),
            Category(name: .life, questions: ["Про жизнь?"], isSelect: false),
            Category(name: .celebrity, questions: ["Знаменитости?"], isSelect: false),
            Category(name: .art, questions: ["Искусство и Кино?"], isSelect: false),
            Category(name: .nature, questions: ["Природа?"], isSelect: false)
        ]
    }
    
    func getQuestions() {
        questions = categories.filter{ $0.isSelect }.flatMap{ $0.questions }
        print(questions)
    }
    
}
