//
//  GameView.swift
//  Bomb
//
//  Created by Илья Шаповалов on 07.08.2023.
//

import SwiftUI

struct GameView: View {
    private let fadeTransition: AnyTransition = .opacity
    @EnvironmentObject var provider: DataProvider
    @StateObject private var store: GameStore
    
    //MARK: - Body
    var body: some View {
        VStack {
            Text(store.title)
                .font(.gameFont(
                    weight: store.gameFlow == .play
                    ? .heavy
                    : .regular)
                )
                .multilineTextAlignment(.center)
                .transition(fadeTransition)
            
            Group {
                switch store.gameFlow == .play {
                case true:
                    AnimatedBombView(duration: store.estimatedTime)
                        .transition(fadeTransition)
                case false:
                    AssetImage(AssetNames.bombImage)
                        .transition(fadeTransition)
                }
            }
            
            if store.gameFlow == .initial {
                PlainButton(title: Localization.beginButtonTitle) {
                    store.send(.launchButtonTap(provider.settings))
                }
                .transition(fadeTransition)
            }
        }
        .padding()
        .background(BackgroundView())
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
        .onAppear {
            store.send(.setupGame(provider.gameState))
        }
        .onDisappear {
            provider.gameState = store.state
        }
    }
    
    //MARK: - init(_:)
    init(store: GameStore = GameDomain.liveStore) {
        self._store = StateObject(wrappedValue: store)
    }
    
    init(state: GameDomain.State) {
        let store = GameStore(
            initialState: state,
            reducer: GameDomain()
        )
        self._store = StateObject(wrappedValue: store)
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView(store: GameDomain.previewStoreInitialState)
                .environmentObject(DataProvider())
        }
        .previewDisplayName("Initial")
        
        NavigationView {
            GameView(store: GameDomain.previewStorePlayState)
                .environmentObject(DataProvider())
        }
        .previewDisplayName("Play")
        
        NavigationView {
            GameView(store: GameDomain.previewStorePauseState)
                .environmentObject(DataProvider())
        }
        .previewDisplayName("Pause")
        
        NavigationView {
            GameView(store: GameDomain.previewStoreGameOverState)
                .environmentObject(DataProvider())
        }
        .previewDisplayName("GameOver")
    }
}
