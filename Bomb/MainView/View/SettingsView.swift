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
    
    var body: some View {
        
        let column: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        ZStack {
            BackgroundGray()
#warning("См. замечания к MainView")
            VStack(spacing: 10) {
                HStack {
                    
                    Button {
                        dismiss()
                    } label: {
                        Image("backArrow")
                    }
                    
                    Spacer()
                    
                    Text("Настройки")
                        .foregroundStyle(Color.primaryTextColor)
                        .font(.system(size: 36, weight: .heavy, design: .rounded))
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image("helpOrange")
                    }
                }
                .padding(20)
                
                VStack {
                    HStack {
                        
                        Text("ВРЕМЯ ИГРЫ")
                            .foregroundStyle(Color.primaryTextColor)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                        Spacer()
                    }
                    
                    LazyVGrid(columns: column, content: {
                        ForEach(vm.gameTimes, id: \.id) { index in
                            
                            Button {
                                
                            } label: {
                                Text(index.title.rawValue)
                                    .foregroundStyle(Color.secondaryTextColor)
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .padding()
                                    .frame(minWidth: 150)
                                    .background(Color.primaryTextColor)
                                    .cornerRadius(15)
                            }
                        }
                    })
                }
                .padding()
                .background(Color.categoryCellBg)
                .cornerRadius(25)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.primaryTextColor, lineWidth: 1)
                )
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Text("Фоновая музыка")
                        Spacer()
                        Picker(selection: $vm.selectedMusic, label: Text("")) {
                            Text("Мелодия 1").tag(0)
                            Text("Мелодия 2").tag(1)
                            Text("Мелодия 3").tag(2)
                        }
                    }
                    .foregroundStyle(Color.secondaryTextColor)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding(12)
                    .background(Color.primaryTextColor)
                    .cornerRadius(15)

                    HStack {
                        Text("Тиканье бомбы")
                        Spacer()
                        Picker(selection: $vm.selectedTickSound, label: Text("")) {
                            Text("Часы 1").tag(0)
                            Text("Часы 2").tag(1)
                            Text("Часы 3").tag(2)
                        }
                    }
                    .foregroundStyle(Color.secondaryTextColor)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding(12)
                    .background(Color.primaryTextColor)
                    .cornerRadius(15)

                    HStack {
                        Text("Взрыв бомбы")
                        Spacer()
                        Picker(selection: $vm.selectedExplosionSound, label: Text("")) {
                            Text("Взрыв 1").tag(0)
                            Text("Взрыв 2").tag(1)
                            Text("Взрыв 3").tag(2)
                        }
                    }
                    .foregroundStyle(Color.secondaryTextColor)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding(12)
                    .background(Color.primaryTextColor)
                    .cornerRadius(15)
                }
                .tint(Color.secondaryTextColor)
                .padding(20)
                .background(Color.categoryCellBg)
                .cornerRadius(25)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.primaryTextColor, lineWidth: 1)
                )
                .padding(.horizontal)
#warning("Повторяющиеся вью стоит вынести в отдельную структуру и переиспользовать.")
                VStack {
                    HStack {
                        Text("Вибрация")
                        Spacer()
                        Toggle(isOn: $vm.withQuestion) {
                            
                        }
                    }
                    .foregroundStyle(Color.secondaryTextColor)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryTextColor)
                    .cornerRadius(15)
                    
                    HStack {
                        Text("Игра с заданиями")
                            .lineLimit(1)
                        Toggle(isOn: $vm.vibration) {
                            
                        }
                    }
                    .foregroundStyle(Color.secondaryTextColor)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryTextColor)
                    .cornerRadius(15)
                }
                .tint(Color.secondaryTextColor)
                .padding(20)
                .cornerRadius(25)
                .frame(maxWidth: .infinity)
                .background(Color.categoryCellBg)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.primaryTextColor, lineWidth: 1)
                )
                .padding(.horizontal)

                Spacer()
            }
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
