//
//  HelpCategoriesView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import SwiftUI

struct HelpCategoriesView: View {
    
    let textData: [(text: String, weight: Font.Weight, size: CGFloat)] = [
        ("Правила игры", .bold, 40),
        ("В игре доступно 6 категорий и более 90 вопросов", .bold, 21),
        ("Можно выбрать сразу несколько категорий для игры", .regular, 21)
    ]
    
    var body: some View {
        ZStack {
            BackgroundView(backgroundColor: .mainBackground)
            
            VStack(spacing: 20) {
                
                dragIndicator
                
                ForEach(textData, id: \.text) { data in
                    styledText(
                        text: data.text,
                        weight: data.weight,
                        size: data.size
                    )
                }
                
                staticCategoryGrid
                
                Spacer()
            }
            .padding(.top)
            .padding(.bottom,4)
            .padding(.horizontal, 20)
        }
        .cornerRadius(24)
    }
    
    var dragIndicator: some View {
        Rectangle()
            .fill(Color.primaryTextColor)
            .frame(width: 68, height: 3)
            .cornerRadius(1.5)
    }
    
    var staticCategoryGrid: some View {
        let column: [GridItem] = [

            GridItem(.adaptive(minimum: 100)),
            GridItem(.adaptive(minimum: 100))
        ]
        let category: [CategoryName] = [
            .art, .celebrity, .sport, .life
        ]
        
        return LazyVGrid(columns: column, alignment: .center, spacing: 16) {
            ForEach(category.indices, id: \.self) { index in
                    CategoryCell(
                        name: category[index],
                        isSelect: index.isMultiple(of: 3) ? true : false
                    )
                }
        }
    }
    
    func styledText(text: String, weight: Font.Weight, size: CGFloat) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .foregroundColor(.primaryTextColor)
            .minimumScaleFactor(0.7)
            .font(.system(size: size, weight: weight, design: .rounded))
            .frame(width: 280, alignment: .center)
    }
}

struct HelpCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        HelpCategoriesView()
    }
}
