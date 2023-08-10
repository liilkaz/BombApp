//
//  RoundedDivider.swift
//  Bomb
//
//  Created by dsm 5e on 10.08.2023.
//

import SwiftUI

struct RoundedDivider: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 100, height: 4)
            .foregroundStyle(Color.primaryTextColor)
            .padding(.top, 5)
    }
}
