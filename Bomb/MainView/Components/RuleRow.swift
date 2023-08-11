//
//  RuleRow.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct RuleRow: View {
    let rule: Rule
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 35, height: 35)
                .foregroundStyle(Color.mainBackground)
                .shadow(radius: 4)
                .overlay {
                    Text("\(rule.number)")
                        .font(.system(size: 15, weight: .heavy, design: .rounded))
                }
            Spacer()
            Text(rule.text)
                .foregroundStyle(Color.primaryTextColor)
                .font(.system(size: 19, weight: .medium, design: .rounded))
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
}

struct RuleRow_Previews: PreviewProvider {
    static var previews: some View {
        RuleRow(rule: Rule(number: 4, text: "Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку."))
    }
}
