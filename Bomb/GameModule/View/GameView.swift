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
            Text("Placeholder")
            Button {
                
            } label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            }
        }
        .navigationTitle("Game")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
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
