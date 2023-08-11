//
//  CategoriesView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var dataProvider: DataProvider
    @ObservedObject var vm: CategoryViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showHelp = false
    @State private var dragValueY = 0.0
    
    var body: some View {
            ZStack {
                
                BackgroundView(backgroundColor: .mainViewButton)

                DynamicCategoryGrid(vm: vm)
                    .padding(.horizontal, 30)

                HelpCategoriesView(vm: vm)
                    .animateSheetOld(showHelp: $showHelp, dragValueY: $dragValueY)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationHeader(showHelp: $showHelp)
            .onAppear {
                vm.getCategories(names: dataProvider.categories)
            }
            .onDisappear {
                dataProvider.categories = vm.save()
            }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoriesView(vm: CategoryViewModel())
        }
    }
}
