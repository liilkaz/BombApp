//
//  SettingsView.swift
//  Bomb
//
//  Created by dsm 5e on 07.08.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataProvider: DataProvider
    
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
                        LazyVGrid(columns: column, content: {                    ForEach(Settings.Duration.allCases) { duration in
                            ButtonLabelView(
                                title: duration.title,
                                isSelected: dataProvider.settings.duration == duration
                            )
                            .onTapGesture {
                                dataProvider.settings.duration = duration
                            }
                        }
                        })
                    }
                    .buttonSectionStyle()
                    VStack {
                        SoundPickerView(title: "Фоновая музыка", selectedOption: $dataProvider.settings.backgroundMelody)
                        SoundPickerView(title: "Тиканье бомбы", selectedOption: $dataProvider.settings.tickSound)
                        SoundPickerView(title: "Взрыв бомбы", selectedOption: $dataProvider.settings.explosionSound)
                    }
                    .tint(Color.secondaryTextColor)
                    .buttonSectionStyle()
                    VStack {
                        ToggleSectionView(title: "Фоновая музыка", toggleValue: $dataProvider.settings.musicEnable)
                        ToggleSectionView(title: "Вибрация", toggleValue: $dataProvider.settings.vibrationEnabled)
                        ToggleSectionView(title: "Игра с заданиями", toggleValue: $dataProvider.settings.questionsEnabled)
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
            SettingsView()
                .environmentObject(DataProvider())
        }
    }
}
