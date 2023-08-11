//
//  PauseButton.swift
//  Bomb
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import SwiftUI

struct PauseButton: ToolbarContent {
    let isPaused: Bool
    let action: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: action) {
                Image(systemName: isPaused
                      ? AssetNames.playIcon
                      : AssetNames.pauseIcon
                )
                .foregroundStyle(Color.primaryTextColor)
            }
        }
    }
}
