//
//  BackgroundView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct BackgroundView: View {
    
    var backgroundColor: Color = .mainViewButton
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            Image("Topographic 3")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.3)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(backgroundColor: .mainBackground)
    }
}
