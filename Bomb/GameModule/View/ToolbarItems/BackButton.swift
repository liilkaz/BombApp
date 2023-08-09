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
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(.black)
            }
        }
    }
}
