//
//  View+Extension.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

extension View {
    func modifiedText(size: CGFloat) -> some View {
        self.modifier(TextModifier(size: size))
    }
    
    func mainShadow() -> some View {
        self.modifier(ShadowModifier())
    }

    func buttonSectionStyle() -> some View {
        self.modifier(ButtonSectionModifier())
    }
}
