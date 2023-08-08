//
//  CategoriesView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import SwiftUI

struct CategoriesView: View {
    
    @ObservedObject var vm: CategoryViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showHelp = false
    @State private var dragValueY = 0.0
    
    var body: some View {
            ZStack(alignment: .bottom) {
                
                BackgroundView(backgroundColor: .mainViewButton)

                dynamicCategoryGrid

                HelpCategoriesView()
                    .animateSheet(showHelp: $showHelp, dragValueY: $dragValueY)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationHeader(showHelp: $showHelp)
            .onDisappear {
                vm.getQuestions()
            }
    }
    
    var dynamicCategoryGrid: some View {
        let column: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return LazyVGrid(columns: column, alignment: .center, spacing: 20) {
            ForEach(vm.categories.indices, id: \.self) { index in
                CategoryCell(
                    name: vm.categories[index].name,
                    isSelect: vm.categories[index].isSelect
                )
                .onTapGesture {
                    vm.categories[index].isSelect.toggle()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.horizontal)
    }

}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(vm: CategoryViewModel())
    }
}
