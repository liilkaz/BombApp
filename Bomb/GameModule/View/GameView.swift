//
//  GameView.swift
//  Bomb
//
//  Created by Илья Шаповалов on 07.08.2023.
//

import SwiftUI

struct GameView: View {
    private let fadeTransition: AnyTransition = .opacity
    
    @StateObject private var store: GameStore
    
    //MARK: - Body
    var body: some View {
        VStack {
            Text(store.title)
                .font(computeFont())
                .multilineTextAlignment(.center)
                .transition(fadeTransition)
            
            Group {
                switch store.gameFlow {
                case .play:
                    EmptyView()
                default:
                    AssetImage(AssetNames.bombImage)
                        .transition(fadeTransition)
                }
            }
            
            if store.gameFlow == .initial {
                PlainButton(title: Localization.beginButtonTitle) {
                    store.send(.launchButtonTap)
                }
                .transition(fadeTransition)
            }
        }
        .padding()
        .navigationTitle(Localization.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar(content: BackButton.init)
        .toolbar { 
            PauseButton { store.send(.pauseButtonTap) }
        }
        .sheet(
            isPresented: Binding(
                get: { store.isShowSheet },
                set: { _ in store.send(.dismissSheet) })
        ) {
            GameOverSheet(store: store)
        }
        .animation(.easeInOut, value: store.gameFlow)
        .onAppear{ store.send(.viewAppeared) }
    }
    
    //MARK: - init(_:)
    init(store: GameStore = GameDomain.liveStore) {
        self._store = StateObject(wrappedValue: store)
    }
    
    private func computeFont() -> Font {
        if store.gameFlow == .play {
            return .appRounded().bold()
        }
        return .appRounded()
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView(store: GameDomain.previewStoreInitialState)
        }
        .previewDisplayName("Initial")
        
        NavigationView {
            GameView(store: GameDomain.previewStorePlayState)
        }
        .previewDisplayName("Play")
        
        NavigationView {
            GameView(store: GameDomain.previewStorePauseState)
        }
        .previewDisplayName("Pause")
        
        NavigationView {
            GameView(store: GameDomain.previewStoreGameOverState)
        }
        .previewDisplayName("GameOver")
    }
}
