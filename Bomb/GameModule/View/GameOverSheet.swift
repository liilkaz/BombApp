//
//  GameOverSheet.swift
//  Bomb
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import SwiftUI

struct GameOverSheet: View {
    private struct Drawing {
        static let contentSpacing: CGFloat = 15
    }
    
    @ObservedObject var store: GameStore
    
    var body: some View {
        VStack(spacing: Drawing.contentSpacing) {
            Text(store.title)
                .font(.appRounded().bold())
            Spacer()
            AssetImage("ExplosionImage")
            Text(store.punishment)
                .font(.appRounded())
                .multilineTextAlignment(.center)
                .padding()
            PlainButton(title: "Another quest") {
                store.send(.anotherPunishmentButtonTap)
            }
            PlainButton(title: "Play again") {
                store.send(.playAgainButtonTap)
            }
        }
        .padding()
    }
}

struct GameOverSheet_Previews: PreviewProvider {
    static var previews: some View {
        GameOverSheet(store: GameDomain.previewStoreGameOverState)
    }
}
