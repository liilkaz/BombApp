//
//  SettingsView.swift
//  Bomb
//
//  Created by dsm 5e on 07.08.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: MainViewModel
    @State private var selectedMusic: Melody = .melody1
    @State private var selectedTickSound: Melody = .melody1
    @State private var selectedExplosionSound: Melody = .melody1
    
    let melodyOptions: [MelodyOption] = [
        MelodyOption(melody: .melody1, title: "Мелодия 1"),
        MelodyOption(melody: .melody2, title: "Мелодия 2"),
        MelodyOption(melody: .melody3, title: "Мелодия 3")
    ]
    
    let column: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            BackgroundGray()
            
            VStack {
                SettingsHeaderView { dismiss() }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        SettingsTimeTitle()
                        LazyVGrid(columns: column, content: {                    ForEach(vm.gameTimes, id: \.id) { index in
                            ButtonLabelView(title: index.title.rawValue)
                        }
                        })
                    }
                    .buttonSectionStyle()
                    VStack {
                        SoundPickerView(title: "Фоновая музыка", options: melodyOptions, selectedOption: $selectedMusic)
                        SoundPickerView(title: "Тиканье бомбы", options: melodyOptions, selectedOption: $selectedTickSound)
                        SoundPickerView(title: "Взрыв бомбы", options: melodyOptions, selectedOption: $selectedExplosionSound)
                    }
                    .tint(Color.secondaryTextColor)
                    .buttonSectionStyle()
                    VStack {
                        ToggleSectionView(title: "Вибрация", toggleValue: $vm.withQuestion)
                        ToggleSectionView(title: "Игра с заданиями", toggleValue: $vm.vibration)
                    }
                    .buttonSectionStyle()
                }
                Spacer()
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarBackButtonHidden()
        }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(vm: MainViewModel())
        }
    }
}
