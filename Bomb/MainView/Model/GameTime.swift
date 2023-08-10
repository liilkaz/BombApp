//
//  GameTime.swift
//  Bomb
//
//  Created by dsm 5e on 08.08.2023.
//

import Foundation

struct GameTime {
    let id = UUID()
    let timeCount: Int
    let title: GameTimeTitle
}

enum GameTimeTitle: String {
    case short = "Короткое"
    case middle = "Среднее"
    case long = "Длинное"
    case random = "Случайное"
}
