//
//  CustomSheetModifier.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct CustomSheetModifier: ViewModifier {
    @Binding var showHelp: Bool
    @Binding var dragValueY: Double
    let pathScreen: CGFloat
    
    private let startingOffsetY: CGFloat = UIScreen.main.bounds.height

    func body(content: Content) -> some View {
        content
            .offset(y: showHelp
                    ? pathScreen
                    : startingOffsetY)
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
                            }
                            dragValueY = 0
                        }
                    }
            )
    }
}

extension View {
    func animateSheet(showHelp: Binding<Bool>, dragValueY: Binding<Double>, pathScreen: CGFloat) -> some View {
        modifier(CustomSheetModifier(showHelp: showHelp, dragValueY: dragValueY, pathScreen: pathScreen))
    }
}

