//
//  BackButton.swift
//  Bomb
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import SwiftUI

struct BackButton: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: dismiss.callAsFunction) {
                Image(systemName: AssetNames.backButtonIcon)
                    .foregroundStyle(Color.primaryTextColor)
            }
        }
    }
}
