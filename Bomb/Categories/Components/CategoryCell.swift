//
//  CategoryCell.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import SwiftUI

struct CategoryCell: View {
    
    let name: CategoryName
    var isSelect: Bool
    
    var body: some View {
        VStack(spacing: 7) {
            Image("\(name.self)")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(minHeight: 60, maxHeight: 80)
                .foregroundColor(isSelect ? .mainBackground : .primaryTextColor)
                .shadow(color: isSelect ? .black : .clear, radius: 2, x: 2, y: 2)
            
            Text(name.rawValue)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(isSelect ? .mainBackground.opacity(0.9) : .primaryTextColor)
                .padding(.horizontal, 6)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .shadow(color: isSelect ? .black : .clear, radius: 1, x: 2, y: 2)
        }
        .padding([.vertical, .top], 24)
        .frame(
            minWidth: (UIScreen.main.bounds.width - 100) / 2,
            maxWidth: (UIScreen.main.bounds.width - 70) / 2,
            minHeight: (UIScreen.main.bounds.width - 100) / 2,
            maxHeight: (UIScreen.main.bounds.width - 70) / 2)
        .overlay(
            Image("checkbox")
                .renderingMode(.template)
                .foregroundColor(isSelect ? .mainBackground : .primaryTextColor)
                .shadow(color: isSelect ? .black : .clear, radius: 2, x: 2, y: 2),
            alignment: .topLeading
        )
        .background(
            Color.categoryCellBg.cornerRadius(20)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelect ? Color.mainBackground : Color.primaryTextColor, lineWidth: 2)
                .shadow(color: isSelect ? .black : .primaryTextColor, radius: 10, x: 5, y: 5)
        )
    }
}

struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(name: .sport, isSelect: true)
    }
}
