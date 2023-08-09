//
//  MainViewSheet.swift
//  Bomb
//
//  Created by dsm 5e on 07.08.2023.
//

import SwiftUI

struct MainHelpSheet: View {
    
    let rowData: [(number: Int, text: String)] = [
        (1, "Все игроки становятся в круг."),
        (2, "Первый игрок берет телефон и нажимает кнопку Старт игры."),
        (3, "На экране появляется вопрос Назовите фрукт"),
        (4, "Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку."),
        (5, "Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба."),
        (6, "Проигравшим считается тот, в чьих руках взорвалась бомба."),
        (7, "Если выбран режим игры С Заданиями, то проигравший выполняет задание."),
    ]
    
    var body: some View {
        ZStack {
            BackgroundGray()
            #warning("См. замечания к MainView")
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 100, height: 4)
                    .foregroundStyle(Color.primaryTextColor)
                    .padding(.top, 5)
                
                Text("ПРАВИЛА ИГРЫ")
                    .foregroundStyle(Color.primaryTextColor)
                    .font(.system(size: 36, weight: .heavy, design: .rounded))
                
                VStack(spacing: 15) {
                    ForEach(rowData, id: \.number) { row in
                        HStack {
                            Circle()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(Color.mainBackground)
                                .shadow(radius: 4)
                                .overlay {
                                    Text("\(row.number)")
                                        .font(.system(size: 15, weight: .heavy, design: .rounded))
                                }
                            Spacer()
                            Text(row.text)
                                .font(.system(size: 19, weight: .medium, design: .rounded))
                            Spacer()
                        }
                        .multilineTextAlignment(.center)
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct MainHelpSheet_Previews: PreviewProvider {
    static var previews: some View {
        MainHelpSheet()
    }
}
