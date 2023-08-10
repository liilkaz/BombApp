//
//  TextModifier.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct TextModifier: ViewModifier {
    let size: CGFloat
    
    init(size: CGFloat) {
        self.size = size
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: .heavy, design: .rounded))
            .foregroundStyle(Color.secondaryTextColor)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}
