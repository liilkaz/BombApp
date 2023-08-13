//
//  TitleLabel.swift
//  Bomb
//
//  Created by Илья Шаповалов on 12.08.2023.
//

import SwiftUI

struct TitleLabel: View, Equatable {
    private struct Titles {
        static let initial = "Нажмите запустить, чтобы начать игру"
        static let pause = "Пауза..."
    }
    
    let flow: GameDomain.State.GameFlow
    let question: String
    
    var body: some View {
        Group {
            switch flow {
            case .initial:
                Text(Titles.initial)
                    .font(.gameFont(weight: .regular))
                
            case .pause:
                Text(Titles.pause)
                    .font(.gameFont(weight: .regular))
            default:
                Text(question)
                    .font(.gameFont(weight: .heavy))
            }
        }
        .multilineTextAlignment(.center)
        .animation(.easeInOut, value: flow)
    }
    
    static func == (lhs: TitleLabel, rhs: TitleLabel) -> Bool {
        return lhs.flow == rhs.flow &&
        lhs.question == rhs.question
    }
}


struct TitleLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TitleLabel(flow: .initial, question: "Some loooong question...")
            TitleLabel(flow: .play, question: "Some loooong question...")
            TitleLabel(flow: .pause, question: "Some loooong question...")
            TitleLabel(flow: .gameOver, question: "Some loooong question...")
        }
    }
}
