//
//  CategoryCell.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//
#warning("Не удалил копипасту")
//
//  CategoryCell.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

//
//  CategoryCell.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 07.08.2023.
//

import SwiftUI

struct CategoryCell: View {
    
    let name: CategoryName
    #warning("Название переменной грамматически некорректное. isSelected более корректное.")
    var isSelect: Bool
    
    var body: some View {
#warning("""
Плохая практика использовать magic numbers в верстке.
Почитай статью https://betterprogramming.pub/cleaning-code-refactoring-in-swiftui-6e288a05bc2d
Вынеси их в отдельную приватную структуру или enum.
""")
        VStack(spacing: 7) {
            CellImageView(name: name, isSelect: isSelect)
            
            CellTextView(name: name, isSelect: isSelect)
        }
        .padding([.vertical, .top], 24)
        .frame(
            minWidth: (UIScreen.main.bounds.width - 100) / 2,
            maxWidth: (UIScreen.main.bounds.width - 70) / 2,
            minHeight: (UIScreen.main.bounds.width - 100) / 2,
            maxHeight: (UIScreen.main.bounds.width - 70) / 2)
        .background(
            Color.categoryCellBg.cornerRadius(20)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelect ? Color.mainBackground : Color.primaryTextColor, lineWidth: 2)
                .shadow(color: isSelect ? .black : .primaryTextColor, radius: 10, x: 5, y: 5)
        )
        .overlay(
            CellCheckboxView(isSelect: isSelect), alignment: .topLeading
        )
    }
}

struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        #warning("Если верстка имеет несколько состояний, лучше отображать их все")
        VStack {
            CategoryCell(name: .sport, isSelect: true)
            CategoryCell(name: .sport, isSelect: false)
        }
    }
}
