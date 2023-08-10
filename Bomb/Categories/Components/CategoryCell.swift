//
//  CategoryCell.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import SwiftUI

struct CategoryCell: View {
    
    private struct Configuration {
        static let itemSpacing: CGFloat = 7
        static let stackSpacing: CGFloat = 24
        static var minItemSize: CGFloat {
            (UIScreen.main.bounds.width - 100) * 0.5
        }
        static var maxItemSize: CGFloat {
            (UIScreen.main.bounds.width - 100) * 0.5
        }
        static let cornerSize: CGFloat = 20
        static let strokeWidth: CGFloat = 2
        static let shadowRadius: CGFloat = 10
        static let ofsetShadow: CGFloat = 5
    }
    
    @Binding var category: Category
    
    var body: some View {
        VStack(spacing: Configuration.itemSpacing) {
            CellImageView(name: category.name, isSelected: category.isSelected)
            
            CellTextView(name: category.name, isSelected: category.isSelected)
        }
        .onTapGesture {
            category.isSelected.toggle()
        }
        .padding([.vertical, .top], Configuration.stackSpacing)
        .frame(
            minWidth: Configuration.minItemSize,
            maxWidth: Configuration.maxItemSize,
            minHeight: Configuration.minItemSize,
            maxHeight: Configuration.maxItemSize
        )
        .background(
            Color.categoryCellBg.cornerRadius(Configuration.cornerSize)
        )
        .overlay(
            RoundedRectangle(cornerRadius: Configuration.cornerSize)
                .stroke(
                    category.isSelected
                        ? Color.mainBackground
                        : Color.primaryTextColor,
                    lineWidth: Configuration.strokeWidth
                )
                .shadow(
                    color: category.isSelected
                        ? .black
                        : .primaryTextColor,
                    radius: Configuration.shadowRadius,
                    x: Configuration.ofsetShadow,
                    y: Configuration.ofsetShadow
                )
        )
        .overlay(
            CellCheckboxView(isSelected: category.isSelected), alignment: .topLeading
        )
    }
}

struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CategoryCell(category: .constant(Category(name: .art, questions: ["Hello"], isSelected: true)))
            CategoryCell(category: .constant(Category(name: .art, questions: ["Hello"], isSelected: false)))
        }
    }
}
