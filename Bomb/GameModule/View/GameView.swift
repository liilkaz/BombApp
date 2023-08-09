//
//  GameView.swift
//  Bomb
//
//  Created by Илья Шаповалов on 07.08.2023.
//

import SwiftUI

struct GameView: View {
    @StateObject private var store: GameStore
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            Text(store.title)
            
        }
        .onAppear{ store.send(.viewAppeared) }
        .navigationTitle("Game")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.black)
                }
            }
        }
    }
    
    init(store: GameStore = GameDomain.liveStore) {
        self._store = StateObject(wrappedValue: store)
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
