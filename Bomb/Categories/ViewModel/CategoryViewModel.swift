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
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.$categories
            .sink { [weak self] _ in
                self?.getQuestions()
            }
            .store(in: &cancellable)
        categories = CategoryData.questions
//        guard let ids = getID() else { return }
//        reduceCategories(ids: ids)
    }
    
    func saveID() {
        let ids = categories.filter(\.isSelected).map(\.id)
        let encoded = try? JSONEncoder().encode(ids)
        UserDefaults.standard.set(encoded, forKey: "indetifible")
    }
    
//    func getID() -> [UUID]? {
//        guard
//            let data = UserDefaults.standard.data(forKey: "indetifible"),
//            let ids = try? JSONDecoder().decode([UUID].self, from: data) else { return nil }
//        print(ids.count)
//        return ids
//    }
//    
//    func reduceCategories(ids: [UUID]) {
//        categories = categories.reduce(into: [Category]()) { partialResult, category in
//            if ids.contains(category.id) {
//                var chosen = category
//                chosen.isSelected = true
//                partialResult.append(chosen)
//            } else {
//                partialResult.append(category)
//            }
//        }
//    }
    
    func getQuestions() {
        questions = categories.filter(\.isSelected).flatMap(\.questions)
    }
    
    func leaveScreen() -> Bool {
        return categories.filter(\.isSelected).count != 0
    }
    
}
