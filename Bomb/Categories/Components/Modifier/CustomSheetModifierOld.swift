//
//  CustomSheetModifier.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct CustomSheetModifierOld: ViewModifier {
    @Binding var showHelp: Bool
    @Binding var dragValueY: Double
    
    private let startingOffsetY: CGFloat = UIScreen.main.bounds.height

    func body(content: Content) -> some View {
        content
            .offset(y: showHelp ? UIScreen.main.bounds.height / 26 : startingOffsetY)
            .offset(y: dragValueY)
            .animation(.spring(), value: showHelp)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height >= 0 {
                            dragValueY = value.translation.height
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if dragValueY >= 300 {
                                showHelp.toggle()
                            }
                            dragValueY = 0
                        }
                    }
            )
    }
}

extension View {
    func animateSheetOld(showHelp: Binding<Bool>, dragValueY: Binding<Double>) -> some View {
        modifier(CustomSheetModifierOld(showHelp: showHelp, dragValueY: dragValueY))
    }
}

