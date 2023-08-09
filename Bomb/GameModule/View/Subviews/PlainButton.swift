//
//  PlainButton.swift
//  Bomb
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import SwiftUI

struct PlainButton: View {
    let title: String
    var textColor: Color = .black
    var backgroundColor: Color = .yellow
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.appRounded(.title2))
                .foregroundStyle(textColor)
                .frame(maxWidth: .infinity, minHeight: 55)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
        }
    }
}

struct PlainButton_Previews: PreviewProvider {
    static var previews: some View {
        PlainButton(title: "Button title", action: { })
    }
}
