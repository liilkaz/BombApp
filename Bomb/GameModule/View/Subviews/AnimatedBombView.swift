//
//  AnimatedBombView.swift
//  Bomb
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import SwiftUI

struct AnimatedBombView: View {
    let animationSpeed: Double
    
    var body: some View {
        LottieView("BombAnimation", animationSpeed: animationSpeed)
    }
    
    init(duration: Int) {
        let speed = Double(duration) * 0.02
        self.animationSpeed = if speed > 1 { 1 } else { speed }
    }
}

struct AnimatedBombView_Preview: PreviewProvider {
    static var previews: some View {
        AnimatedBombView(duration: 30)
    }
}
