//
//  StaticCategoryGrid.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 09.08.2023.
//

import SwiftUI

struct StaticCategoryGrid: View {
    
    private struct Configuration {
        static let gridSpacing: CGFloat = 20
    }
    
    @State private var categories: [Category] = [
        Category(name: .varied, questions: [], isSelected: true),
        Category(name: .sport, questions: [], isSelected: false),
        Category(name: .life, questions: [], isSelected: false),
        Category(name: .celebrity, questions: [], isSelected: true)
    ]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: Configuration.gridSpacing
        ) {
            ForEach($categories, content: CategoryCell.init)
        }
    }
}

struct StaticCategoryGrid_Previews: PreviewProvider {
    static var previews: some View {
        StaticCategoryGrid()
    }
}
