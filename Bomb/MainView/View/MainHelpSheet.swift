//
//  MainViewSheet.swift
//  Bomb
//
//  Created by dsm 5e on 07.08.2023.
//

import SwiftUI

struct MainHelpSheet: View {
    let rowData: [Rule] = [
        Rule(number: 1, text: "Все игроки становятся в круг."),
        Rule(number: 2, text: "Первый игрок берет телефон и нажимает кнопку Старт игры."),
        Rule(number: 3, text: "На экране появляется вопрос Назовите фрукт"),
        Rule(number: 4, text: "Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку."),
        Rule(number: 5, text: "Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба."),
        Rule(number: 6, text: "Проигравшим считается тот, в чьих руках взорвалась бомба."),
        Rule(number: 7, text: "Если выбран режим игры С Заданиями, то проигравший выполняет задание."),
    ]
    
    let titleFontSize: CGFloat = 36
    
    var body: some View {
        ZStack {
            BackgroundGray()
            
            VStack {
                RoundedDivider()
                
                Text("ПРАВИЛА ИГРЫ")
                    .foregroundStyle(Color.primaryTextColor)
                    .modifiedText(size: titleFontSize)
                
                VStack(spacing: 15) {
                    ForEach(rowData) { rule in
                        RuleRow(rule: rule)
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
