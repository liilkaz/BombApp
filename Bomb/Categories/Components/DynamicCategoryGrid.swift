//
//  DynamicCategoryGrid.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 09.08.2023.
//

import SwiftUI

struct DynamicCategoryGrid: View {
    
    private struct Configuration {
        static let gridSpacing: CGFloat = 20
    }
    
    @ObservedObject var vm: CategoryViewModel

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
            ForEach($vm.categories, content: CategoryCell.init)
        }
    }
}

struct DynamicCategoryGrid_Previews: PreviewProvider {
    static var previews: some View {
        DynamicCategoryGrid(vm: CategoryViewModel())
    }
}
