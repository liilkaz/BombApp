//
//  ButtonLabelView.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct ButtonLabelView: View {
    var title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .modifiedText(size: 18)
            .padding()
            .frame(minWidth: 150)
            .background(isSelected ? .red : Color.primaryTextColor)
            .cornerRadius(15)
    }
}
