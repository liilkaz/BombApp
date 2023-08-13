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
                            HStack(spacing: 20) {
                                Text("Короткое")
                                    .foregroundColor(.secondaryTextColor)
                                    .modifiedText(size: 14)
                                    .padding(.all, 10)
                                    .frame(width: 130)
                                    .background(Color.primaryTextColor)
                                    .cornerRadius(15)
                                
                                Text("• Бомба взорвется в течение 10 секунд.")
                                    .foregroundStyle(Color.primaryTextColor)
                                    .lineLimit(2)
                                    .modifiedText(size: smallText)
                            }
                            
                            HStack(spacing: 20) {
                                Text("Среднее")
                                    .foregroundColor(.primaryTextColor)
                                    .modifiedText(size: 14)
                                    .padding(.all, 10)
                                    .frame(width: 130)
                                    .background(Color.mainBackground)
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(
                                                Color.primaryTextColor,
                                                lineWidth: 3
                                            )
                                    )
                                
                                Text("• Бомба взорвется в течение 20 секунд.")
                                    .foregroundStyle(Color.primaryTextColor)
                                    .lineLimit(2)
                                    .modifiedText(size: smallText)
                            }
                            
                            HStack(spacing: 20) {
                                Text("Длинное")
                                    .foregroundColor(.secondaryTextColor)
                                    .modifiedText(size: 14)
                                    .padding(.all, 10)
                                    .frame(width: 130)
                                    .background(Color.primaryTextColor)
                                    .cornerRadius(15)
                                
                                Text("• Бомба взорвется в течение 45 секунд.")
                                    .foregroundStyle(Color.primaryTextColor)
                                    .lineLimit(2)
                                .modifiedText(size: smallText)
                            }
                            
                            HStack(spacing: 20) {
                                Text("Случайное")
                                    .foregroundColor(.secondaryTextColor)
                                    .modifiedText(size: 14)
                                    .padding(.all, 10)
                                    .frame(width: 130)
                                    .background(Color.primaryTextColor)
                                    .cornerRadius(15)
                                
                                Text("• Бомба взорвется в течение 10-45 секунд.")
                                    .foregroundStyle(Color.primaryTextColor)
                                    .lineLimit(2)
                                .modifiedText(size: smallText)
                            }
                        }
                        .padding(.bottom)
                        
                        Text("•Если выбран режим «С Заданиями!», то после взрыва бомбы на экране будет появляться задание для проигравшего игрока.")
                            .foregroundStyle(Color.primaryTextColor)
                            .lineLimit(4)
                            .modifiedText(size: smallText)
                        
                        Text("Также в настройках \n можно")
                            .foregroundStyle(Color.primaryTextColor)
                            .lineLimit(2)
                            .modifiedText(size: largeText)
                            .multilineTextAlignment(.center)
                            .overlay(
                                Rectangle()
                                    .fill(Color.mainBackground)
                                    .frame(height: 2),
                                alignment: .center
                            )
                            .overlay(
                                Rectangle()
                                    .fill(Color.mainBackground)
                                    .frame(width: 80, height: 2),
                                alignment: .bottom
                            )

                        VStack(alignment: .leading, spacing: 10) {
                            Text("• Включить / Отключить фоновую\nмузыку.")
                                .foregroundStyle(Color.primaryTextColor)
                                .lineLimit(2)
                                .modifiedText(size: smallText)
                            
                            Text("• Выбрать звуки для фоновой музыки,\nтиканья бомбы и взрыва.")
                                .foregroundStyle(Color.primaryTextColor)
                                .lineLimit(2)
                                .modifiedText(size: smallText)
                        }
                    }
                    .padding(.bottom, 100)
                }
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
