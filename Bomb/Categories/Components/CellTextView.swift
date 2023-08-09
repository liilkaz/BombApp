//
//  CellTextView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct CellTextView: View {
    
    private struct Configuration {
        static let font: Font = .system(
            size: 20,
            weight: .semibold,
            design: .rounded
        )
        static let itemPadding: CGFloat = 6
        static let scaleFactor: CGFloat = 0.5
        static let shadowRadius: CGFloat = 1
        static let ofsetShadow: CGFloat = 2
    }
    
    let name: CategoryName
    var isSelected: Bool
    
    var body: some View {
        Text(name.rawValue)
            .font(Configuration.font)
            .foregroundColor(isSelected ? .mainBackground : .primaryTextColor)
            .padding(.horizontal, Configuration.itemPadding)
            .lineLimit(1)
            .minimumScaleFactor(Configuration.scaleFactor)
            .shadow(
                color: isSelected ? .black : .clear,
                radius: Configuration.shadowRadius,
                x: Configuration.ofsetShadow,
                y: Configuration.ofsetShadow
            )
    }
}

struct CellTextView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CellTextView(name: .art, isSelected: true)
            CellTextView(name: .art, isSelected: false)
        }
    }
}
