//
//  CustomToolbarModifier.swift
//  Bomb
//
//  Created by Kasharin Mikhail on 08.08.2023.
//

import SwiftUI

struct CustomToolbarModifier: ViewModifier {
    @ObservedObject var vm: CategoryViewModel
    @Binding var showHelp: Bool
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Категории")
                        .foregroundColor(.primaryTextColor)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 12, height: 20)
                        .onTapGesture {
                            dismiss()
                        }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("helpicon")
                        .onTapGesture {
                            withAnimation {
                                showHelp.toggle()
                            }
                        }
                }
            }
    }
}

extension View {
    func navigationHeader(showHelp: Binding<Bool>) -> some View {
        self.modifier(CustomToolbarModifier(vm: CategoryViewModel(), showHelp: showHelp))
    }
}

