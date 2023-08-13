//
//  BombContentView.swift
//  Bomb
//
//  Created by Илья Шаповалов on 12.08.2023.
//

import SwiftUI

struct BombContentView: View, Equatable {
    private let fadeTransition: AnyTransition = .opacity
    
    let gameFlow: GameDomain.State.GameFlow
    
    var body: some View {
        Group {
            switch gameFlow {
            case .initial, .pause:
                AssetImage(AssetNames.bombImage)
                    .transition(fadeTransition)
            case .play:
                LottieView(
                    AssetNames.bombAnimation,
                    loopMode: .autoReverse
                )
                .transition(.scale)
            
            case .explosion:
                LottieView(AssetNames.explosionAnimation)
                
            case .gameOver:
                AssetImage(AssetNames.bombImage)
                    .transition(fadeTransition)
            }
        }
    }
    
    static func == (lhs: BombContentView, rhs: BombContentView) -> Bool {
        lhs.gameFlow == rhs.gameFlow
    }
}

struct BombContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            BombContentView(gameFlow: .initial)
            BombContentView(gameFlow: .play)
            BombContentView(gameFlow: .explosion)
            BombContentView(gameFlow: .gameOver)
        }
    }
}
