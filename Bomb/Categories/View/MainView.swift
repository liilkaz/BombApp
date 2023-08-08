//
//  MainView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var vm = CategoryViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("NextScreen") {
                    CategoriesView(vm: vm)
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
