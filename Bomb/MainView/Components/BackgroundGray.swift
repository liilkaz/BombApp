//
//  BackgroundGray.swift
//  Bomb
//
//  Created by dsm 5e on 08.08.2023.
//

import SwiftUI

struct BackgroundGray: View {
    var body: some View {
        ZStack {
            Color.secondaryTextColor
                .ignoresSafeArea()
            Image("bgGray")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
                .scaleEffect(1.3)
        }
    }
}
