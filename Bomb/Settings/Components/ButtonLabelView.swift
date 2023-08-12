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
            .foregroundColor(isSelected ? .primaryTextColor : .secondaryTextColor)
            .modifiedText(size: 18)
            .padding()
            .frame(minWidth: 150)
            .background(isSelected ? Color.mainBackground : Color.primaryTextColor)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(
                        isSelected
                            ? Color.primaryTextColor
                            : .clear,
                        lineWidth: 3
                    )
            )
    }
}

struct ButtonLabelView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ButtonLabelView(title: "Короткое", isSelected: true)
            ButtonLabelView(title: "Короткое", isSelected: false)
        }
    }
}
