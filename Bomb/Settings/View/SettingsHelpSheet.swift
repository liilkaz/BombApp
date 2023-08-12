//
//  SettingsHelpSheet.swift
//  Bomb
//
//  Created by dsm 5e on 12.08.2023.
//

import SwiftUI

struct SettingsHelpSheet: View {
    
    let titleFontSize: CGFloat = 36
    let smallText: CGFloat = 16
    let largeText: CGFloat = 22
    var bottomPadding: CGFloat = 0
    
    var body: some View {
        ZStack {
            BackgroundGray()
            
            VStack {
                RoundedDivider()
                    .padding(.bottom)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        Text("В настройках игры можно \nзадать время взрыва бомбы:")
                            .foregroundStyle(Color.primaryTextColor)
                            .lineLimit(2)
                            .modifiedText(size: largeText)
                            .multilineTextAlignment(.center)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("• Бомба взорвется в течении 10 секунд.")
                                .foregroundStyle(Color.primaryTextColor)
                                .lineLimit(2)
                                .modifiedText(size: smallText)
                            
                            Text("• Бомба взорвется в течении 20 секунд.")
                                .foregroundStyle(Color.primaryTextColor)
                                .lineLimit(2)
                                .modifiedText(size: smallText)
                            
                            Text("• Бомба взорвется в течении 45 секунд.")
                                .foregroundStyle(Color.primaryTextColor)
                                .lineLimit(2)
                                .modifiedText(size: smallText)
                            
                            Text("• Бомба взорвется в течении 10-45 секунд.")
                                .foregroundStyle(Color.primaryTextColor)
                                .lineLimit(1)
                                .modifiedText(size: smallText)
                            
                            Text("• Если выбран режим С заданиями, то после взрыва бомбы на экране будет появляться задание для проигравшего игрока.")
                                .foregroundStyle(Color.primaryTextColor)
                                .lineLimit(4)
                                .modifiedText(size: smallText)
                        }
                        
                        Text("Так же в настройках \n можно")
                            .foregroundStyle(Color.primaryTextColor)
                            .lineLimit(2)
                            .modifiedText(size: largeText)
                            .multilineTextAlignment(.center)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("• Включить / Отключить фоновую музыку.")
                                .foregroundStyle(Color.primaryTextColor)
                                .lineLimit(2)
                                .modifiedText(size: smallText)
                            
                            Text("• Выбрать звуки для фоновой музыки, тиканья бомбы и взрыва.")
                                .foregroundStyle(Color.primaryTextColor)
                                .lineLimit(2)
                                .modifiedText(size: smallText)
                        }
                    }
                }
                .padding(.bottom, bottomPadding)

                Spacer()
            }
            .padding()
        }
    }
}

struct SettingsHelpSheet_Previews: PreviewProvider {
    static var previews: some View {
        SettingsHelpSheet()
    }
}
