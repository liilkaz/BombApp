//
//  Font+.swift
//  Bomb
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import SwiftUI

extension Font {
    static func gameFont(
        size: CGFloat = 28,
        weight: Font.Weight = .regular
    ) -> Font {
        .system(size: size, design: .rounded)
        .weight(weight)
    }
    
}
