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
    private let heavyImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    @EnvironmentObject var provider: DataProvider
    @ObservedObject var store: GameStore
    
    var body: some View {
        VStack(spacing: Drawing.contentSpacing) {
            Text(store.title)
                .font(.gameFont(weight: .heavy))
            Spacer()
            AssetImage(AssetNames.explosionImage)
            if provider.settings.questionsEnabled {
                Text(store.punishment)
                    .font(.gameFont(weight: .medium))
                    .multilineTextAlignment(.center)
                    .padding()
                PlainButton(title: Localization.anotherQuestButtonTitle) {
                    store.send(.anotherPunishmentButtonTap)
                }
            }
            PlainButton(title: Localization.restartGameButtonTitle) {
                store.send(.playAgainButtonTap)
            }
        }
        .padding()
        .background(BackgroundView())
        .onAppear {
            if provider.settings.vibrationEnabled {
                heavyImpact.impactOccurred()
            }
        }
        .onDisappear { store.send(.playAgainButtonTap) }
    }
    
    init(store: GameStore) {
        self.store = store
        if provider.settings.vibrationEnabled {
            heavyImpact.prepare()
        }
    }
}

struct GameOverSheet_Previews: PreviewProvider {
    static var previews: some View {
        GameOverSheet(store: GameDomain.previewStoreGameOverState)
            .environmentObject(DataProvider())
    }
}
