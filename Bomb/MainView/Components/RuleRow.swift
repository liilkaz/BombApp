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
                .font(.system(size: 19, weight: .medium, design: .rounded))
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
}
