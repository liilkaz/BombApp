//
//  MainView.swift
//  Bomb
//
//  Created by dsm 5e on 07.08.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.mainBackground
                Image("bgVectorOrange")
                    .resizable()
                    .scaledToFit()
                VStack {
                    Spacer()
                    Text("Игра для компании")
                        .foregroundStyle(Color.secondaryTextColor)
                        .font(.system(size: 28, weight: .heavy, design: .rounded))
                    
                    Text("БОМБА")
                        .foregroundStyle(Color.secondaryTextColor)
                        .font(.system(size: 48, weight: .heavy, design: .rounded))
                    
                    Spacer()
                    Spacer()
                }
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image("settings")
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Image("helpRed")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    MainView()
}
