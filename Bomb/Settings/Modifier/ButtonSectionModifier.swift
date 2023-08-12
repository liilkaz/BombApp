//
//  ButtonSectionModifier.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct ButtonSectionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(Color.categoryCellBg)
            .cornerRadius(25)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.primaryTextColor, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}
