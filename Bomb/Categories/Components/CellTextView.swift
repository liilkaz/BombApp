//
//  CellTextView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct CellTextView: View {
    let name: CategoryName
    var isSelect: Bool
    
    var body: some View {
        Text(name.rawValue)
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .foregroundColor(isSelect ? .mainBackground.opacity(0.9) : .primaryTextColor)
            .padding(.horizontal, 6)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .shadow(color: isSelect ? .black : .clear, radius: 1, x: 2, y: 2)
    }
}

struct CellTextView_Previews: PreviewProvider {
    static var previews: some View {
        CellTextView(name: .art, isSelect: true)
    }
}
