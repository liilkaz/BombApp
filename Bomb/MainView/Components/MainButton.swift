//
//  MainButton.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct MainButton: View {
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(Color.primaryTextColor)
            .font(.system(size: 20, weight: .medium, design: .rounded))
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.mainViewButton)
            .cornerRadius(10)
    }
}
