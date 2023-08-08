//
//  BackgroundView.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct BackgroundView: View {
    
    var backgroundColor: Color
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            Image("Topographic 3")
                .resizable()
                .scaledToFill()
                .offset(y: -30)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(backgroundColor: .mainBackground)
    }
}
