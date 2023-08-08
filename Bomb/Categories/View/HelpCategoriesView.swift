//
//  HelpCategoriesView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import SwiftUI

struct HelpCategoriesView: View {
    
    let column: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let category: [CategoryName] = [.art, .celebrity, .sport, .life]
    
    var body: some View {
        ZStack {
            Color.mainBackground.ignoresSafeArea()
            Image("Topographic 3")
                .resizable()
                .scaledToFill()
                .offset(y: -30)
            
            VStack(spacing: 24) {
                Rectangle()
                    .fill(Color.primaryTextColor)
                    .frame(width: 68, height: 3)
                    .cornerRadius(1.5)
                
                Text("Правила игры")
                    .foregroundColor(.primaryTextColor)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                
                VStack {
                    Text("В игре доступно 6")
                    Text("категорий и более 90")
                    Text("вопросов")
                }
                .foregroundColor(.primaryTextColor)
                .font(.system(size: 21, weight: .bold, design: .rounded))
                .frame(width: 300, alignment: .center)
                
                VStack {
                    Text("Можно выбрать сразу")
                    Text("несколько категорий для")
                    Text("игры")
                }
                .foregroundColor(.primaryTextColor)
                .font(.system(size: 21, weight: .regular, design: .rounded))
                .frame(width: 300, alignment: .center)
                
                LazyVGrid(columns: column, alignment: .center, spacing: 20) {
                    ForEach(0..<category.count) {
                        CategoryCell(name: category[$0], isSelect: $0.isMultiple(of: 3) ? true : false)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
        .cornerRadius(24)
    }
}

struct HelpCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        HelpCategoriesView()
    }
}
