//
//  CellCheckboxView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct CellCheckboxView: View {
    
    private struct Configuration {
        static let shadowRadius: CGFloat = 2
        static let ofsetShadow: CGFloat = 2
        static let minWidth: CGFloat = 15
        static let maxWidth: CGFloat = 35
    }
    
    var isSelected: Bool
    
    var body: some View {
        Image("checkbox")
            .renderingMode(.template)
            .foregroundColor(isSelected ? .mainBackground : .primaryTextColor)
            .scaledToFit()
            .frame(
                minWidth: Configuration.minWidth,
                maxWidth: Configuration.maxWidth
            )
            .shadow(
                color: isSelected ? .black : .clear,
                radius: Configuration.shadowRadius,
                x: Configuration.ofsetShadow,
                y: Configuration.ofsetShadow
            )
    }
}

struct CellCheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CellCheckboxView(isSelected: false)
            CellCheckboxView(isSelected: true)
        }
    }
}
