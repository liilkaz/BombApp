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
    @StateObject private var store: StoreOf<GameDomain>
    
    private var bindStore: Binding<Bool> {
        .init(
            get: { store.isShowSheet },
            set: { _ in store.send(.dismissSheet) }
        )
    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            VStack {
                TitleLabel(
                    flow: store.gameFlow,
                    question: store.title
                )
                .equatable()
                
                BombContentView(gameFlow: store.gameFlow)
                    .equatable()
                
                if store.gameFlow == .initial {
                    PlainButton(title: Localization.beginButtonTitle) {
                        store.send(.launchButtonTap(provider.settings))
                    }
                    .transition(fadeTransition)
                }
            }
            .padding()
        }
        .navigationTitle(Localization.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar(content: BackButton.init)
        .toolbar {
            PauseButton(
                isPaused: store.gameFlow == .pause,
                action: { store.send(.pauseButtonTap) }
            )
        }
        .sheet(
            isPresented: bindStore,
            onDismiss: dropState,
            content: configureSheet)
        .animation(.easeInOut, value: store.gameFlow)
        .onAppear {
            store.send(.setQuestionCategories(provider.categories))
            store.send(.setupGame)
        }
        .onDisappear {
            provider.gameState = store.state
            store.dispose()
            store.send(.viewDisappear)
        }
    }
    
    //MARK: - init(_:)
    init(store: StoreOf<GameDomain> = GameDomain.liveStore) {
        self._store = StateObject(wrappedValue: store)
    }
    
    init(state: GameDomain.State) {
        let store = Store(
            initialState: state,
            reducer: GameDomain()
        )
        self._store = StateObject(wrappedValue: store)
    }
    
}

private extension GameView {
    //MARK: - Private methods
    func dropState() {
        store.send(.setGameState(.initial))
    }
    
    func configureSheet() -> some View {
        GameOverSheet()
            .environmentObject(provider)
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
