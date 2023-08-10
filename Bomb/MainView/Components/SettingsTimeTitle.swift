//
//  SettingsTimeTitle.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct SettingsTimeTitle: View {
    var body: some View {
        HStack {
            Text("ВРЕМЯ ИГРЫ")
                .foregroundStyle(Color.primaryTextColor)
                .modifiedText(size: 20)
                .padding(.horizontal)
            Spacer()
        }
    }
}
