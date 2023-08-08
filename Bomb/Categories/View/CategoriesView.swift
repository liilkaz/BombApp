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
    
    let column: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let startingOffsetY = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color.mainViewButton.ignoresSafeArea()
                Image("Topographic 3")
                    .resizable()
                    .scaledToFill()
                    .offset(y: -30)
                
                VStack {
                    Spacer()
                    
                    LazyVGrid(columns: column, alignment: .center, spacing: 20) {
                        ForEach(0..<vm.categories.count) { index in
                            CategoryCell(
                                name: vm.categories[index].name,
                                isSelect: vm.categories[index].isSelect
                            )
                                .onTapGesture {
                                    vm.categories[index].isSelect.toggle()
                                }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                
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
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(vm: CategoryViewModel())
    }
}
