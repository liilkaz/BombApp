//
//  MainViewModel.swift
//  Bomb
//
//  Created by dsm 5e on 08.08.2023.
//

import Foundation
import SwiftUI

#warning("Если ты не собираешься наследоваться от этого класса, его нужно пометить как final. См. Swift method dispatch.")
class MainViewModel: ObservableObject {
    
    @Published var gameTimes: [GameTime] = []
    @Published var selectedMusic: Int = 0
    @Published var selectedTickSound: Int = 0
    @Published var selectedExplosionSound: Int = 0
    @Published var vibration: Bool = false
    @Published var withQuestion: Bool = false
    
    init() {
        gameTimes = [
            GameTime(timeCount: 15, title: .short),
            GameTime(timeCount: 30, title: .middle),
            GameTime(timeCount: 45, title: .long),
            GameTime(timeCount: Int.random(in: 0...60), title: .random)
        ]
    }
}
