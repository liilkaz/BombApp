//
//  CustomSheetModifier.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct CustomSheetModifierMain: ViewModifier {
    @Binding var showHelp: Bool
    @Binding var dragValueY: Double
    
    private let startingOffsetY: CGFloat = UIScreen.main.bounds.height

    func body(content: Content) -> some View {
        content
            .offset(y: showHelp ? 130 : startingOffsetY)
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
                            if dragValueY >= 180 {
                                showHelp.toggle()
                                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
                                dragValueY = 0
                            } else {
                                dragValueY -= value.translation.height
                            }
                        }
                    }
            )
    }
}

extension View {
    func animateSheetMain(showHelp: Binding<Bool>, dragValueY: Binding<Double>) -> some View {
        modifier(CustomSheetModifierMain(showHelp: showHelp, dragValueY: dragValueY))
    }
}
