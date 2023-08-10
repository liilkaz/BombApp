//
//  SoundPickerView.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct SoundPickerView: View {
    let title: String
    let options: [MelodyOption]
    @Binding var selectedOption: Melody

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Picker(selection: $selectedOption, label: Text("")) {
                ForEach(options, id: \.melody) { option in
                    Text(option.title).tag(option.melody)
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
