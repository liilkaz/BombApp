//
//  ContentView.swift
//  Bomb
//
//  Created by Лилия Феодотова on 06.08.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.mainBackground
                .ignoresSafeArea()
            VStack {
                Text("Hello, world!")
                    .foregroundColor(.primaryTextColor)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
