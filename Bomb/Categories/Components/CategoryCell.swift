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
                .scaledToFit()
                .frame(height: 80)
            
            Text(name.rawValue)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(isSelect ? .mainBackground : .primaryTextColor)
                .padding(.horizontal, 6)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .padding([.vertical, .top], 24)
        .frame(
            width: (UIScreen.main.bounds.width - 70) / 2,
            height: (UIScreen.main.bounds.width - 70) / 2
        )
        .overlay(
            Image("checkbox")
                .renderingMode(.template)
                .foregroundColor(isSelect ? .mainBackground : .primaryTextColor),
            alignment: .topLeading
        )
        .background(
            Color.categoryCellBg.cornerRadius(20)
        )
    }
}

struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(name: .sport, isSelect: false)
    }
}
