//
//  SoundPickerView.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct SoundPickerView: View {
    let title: String
    @Binding var selectedOption: Settings.Melody

    var body: some View {
        HStack {
            Text(title)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Spacer()
            Picker(selection: $selectedOption, label: Text("")) {
                ForEach(Settings.Melody.allCases) { melody in
                    Text(melody.title).tag(melody)
                }
            }
        }
        .foregroundStyle(Color.secondaryTextColor)
        .font(.system(size: 18, weight: .bold, design: .rounded))
        .padding(12)
        .background(Color.primaryTextColor)
        .cornerRadius(15)
    }
}
