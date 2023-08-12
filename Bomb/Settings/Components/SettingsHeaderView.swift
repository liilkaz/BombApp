//
//  SettingsHeaderView.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct SettingsHeaderView: View {
    
    @Binding var isShowSheet: Bool
    var dismissAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: dismissAction) {
                Image("backArrow")
            }
            
            Spacer()
            
            Text("Настройки")
                .foregroundStyle(Color.primaryTextColor)
                .font(.system(size: 36, weight: .heavy, design: .rounded))
            
            Spacer()
            
            Button {
                withAnimation {
                    isShowSheet = true
                }
            } label: {
                Image("helpOrange")
            }
        }
        .padding(20)
    }
}
