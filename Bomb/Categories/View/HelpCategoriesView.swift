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
        ("В игре доступно 6\nкатегорий и более 90\nвопросов", .bold, 21),
        ("Можно выбрать сразу\nнесколько категорий для\nигры", .regular, 21)
    ]
    
    var body: some View {
        ZStack {
            BackgroundView(backgroundColor: .mainBackground)
            
            VStack(spacing: 24) {
                
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
            .padding([.top, .horizontal])
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
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        let category: [CategoryName] = [
            .art, .celebrity, .sport, .life
        ]
        
        return LazyVGrid(columns: column, alignment: .center, spacing: 20) {
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
            .font(.system(size: size, weight: weight, design: .rounded))
            .frame(width: 300, alignment: .center)
    }
}

struct HelpCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        HelpCategoriesView()
    }
}
