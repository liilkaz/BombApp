//
//  BackgroundOrange.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct BackgroundOrange: View {
    var body: some View {
        ZStack {
            Color.mainBackground
                .ignoresSafeArea()
            
            Image("bgOrange")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
                .scaleEffect(1.4)
        }
    }
}
