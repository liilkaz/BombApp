//
//  Font+.swift
//  Bomb
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import SwiftUI

extension Font {
    static func appRounded(_ style: TextStyle = .title) -> Font {
        .system(style, design: .rounded)
    }
}
