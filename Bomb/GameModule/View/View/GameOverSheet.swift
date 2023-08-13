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
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var provider: DataProvider
    @StateObject var store: StoreOf<GameOverDomain>
    
    var body: some View {
        VStack(spacing: Drawing.contentSpacing) {
            Text(Localization.gameOverTitle)
                .font(.gameFont(weight: .heavy))
            Spacer()
            AssetImage(AssetNames.explosionImage)
            if provider.settings.questionsEnabled {
                Text(store.quest)
                    .font(.gameFont(weight: .medium))
                    .multilineTextAlignment(.center)
                    .padding()
                    .animation(.spring(), value: store.quest)
                PlainButton(title: Localization.anotherQuestButtonTitle) {
                    store.send(.anotherPunishmentButtonTap)
                }
            }
            PlainButton(
                title: Localization.restartGameButtonTitle,
                action: dismiss.callAsFunction
            ) 
        }
        .padding()
        .background(BackgroundView())
        .onAppear {
            store.send(.viewAppeared)
            if provider.settings.vibrationEnabled {
                heavyImpact.impactOccurred()
            }
        }
    }
    
    init(store: StoreOf<GameOverDomain> = GameOverDomain.liveStore) {
        self._store = StateObject(wrappedValue: store)
        self.heavyImpact.prepare()
    }
}

struct GameOverSheet_Previews: PreviewProvider {
    static var previews: some View {
        GameOverSheet(store: GameOverDomain.previewStore)
            .environmentObject(DataProvider())
    }
}
