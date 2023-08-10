//
//  CellImageView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct CellImageView: View {
    
    private struct Configuration {
        static let minHeight: CGFloat = 50
        static let maxHeight: CGFloat = 80
        static let shadowRadius: CGFloat = 2
        static let ofsetShadow: CGFloat = 2
    }
    
    let name: CategoryName
    var isSelected: Bool
    
    var body: some View {
        Image(name.imageName)
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .frame(
                minHeight: Configuration.minHeight,
                maxHeight: Configuration.maxHeight
            )
            .foregroundColor(isSelected ? .mainBackground : .primaryTextColor)
            .shadow(
                color: isSelected ? .black : .clear,
                radius: Configuration.shadowRadius,
                x: Configuration.ofsetShadow,
                y: Configuration.ofsetShadow
            )
    }
}

struct CellImageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CellImageView(name: .celebrity, isSelected: false)
            CellImageView(name: .celebrity, isSelected: true)
        }
    }
}
