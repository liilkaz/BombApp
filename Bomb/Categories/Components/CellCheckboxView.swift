//
//  CellCheckboxView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct CellCheckboxView: View {
    var isSelect: Bool
    
    var body: some View {
        Image("checkbox")
            .renderingMode(.template)
            .foregroundColor(isSelect ? .mainBackground : .primaryTextColor)
            .shadow(color: isSelect ? .black : .clear, radius: 2, x: 2, y: 2)
    }
}

struct CellCheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        CellCheckboxView(isSelect: false)
    }
}
