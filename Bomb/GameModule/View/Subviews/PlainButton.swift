//
//  PlainButton.swift
//  Bomb
//
//  Created by Илья Шаповалов on 09.08.2023.
//

import SwiftUI

struct PlainButton: View {
    private struct Drawing {
        static let fontSize: CGFloat = 22
        static let height: CGFloat = 55
        static let cornerRadius: CGFloat = 10
        static let shadowRadius: Double = 5
    }
    
    let title: String
    var textColor: Color = .primaryTextColor
    var backgroundColor: Color = .gameViewButtonColor
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.gameFont(
                    size: Drawing.fontSize,
                    weight: .semibold)
                )
                .foregroundStyle(textColor)
                .frame(
                    maxWidth: .infinity,
                    minHeight: Drawing.height
                )
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: Drawing.cornerRadius))
                .shadow(radius: Drawing.shadowRadius)
        }
    }
}

struct PlainButton_Previews: PreviewProvider {
    static var previews: some View {
        PlainButton(title: "Button title", action: { })
    }
}
