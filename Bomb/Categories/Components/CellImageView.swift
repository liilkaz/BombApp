//
//  CellImageView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct CellImageView: View {
    let name: CategoryName
    var isSelect: Bool
    
    var body: some View {
        Image("\(name.self)")
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .frame(minHeight: 60, maxHeight: 80)
            .foregroundColor(isSelect ? .mainBackground : .primaryTextColor)
            .shadow(color: isSelect ? .black : .clear, radius: 2, x: 2, y: 2)
    }
}

struct CellImageView_Previews: PreviewProvider {
    static var previews: some View {
        CellImageView(name: .celebrity, isSelect: false)
    }
}
