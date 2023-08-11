//
//  MainView.swift
//  Bomb
//
//  Created by dsm 5e on 07.08.2023.
//

import SwiftUI

struct MainView: View {
    let smallTitle: CGFloat = 36
    let largeTitle: CGFloat = 48
    let imageWidth: CGFloat = 300
    let scaleEffectStart: CGFloat = 1.1
    let scaleEffectEnd: CGFloat = 1.0
    let maxTapCount: Int = 6
    let maxDegrees: Double = 360
    let minDegrees: Double = 0
    let response: Double = 0.4
    let dampingFriction: Double = 0.5
    let startOffset: CGFloat = -10
    let endOffset: CGFloat = 0
    let cornerRadius: CGFloat = 20
    
    @State private var impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    @State private var showSettings: Bool = false
    @State private var isShowSheet: Bool = false
    @State private var isTapped: Bool = false
    @State private var tapCount: Int = 0
    @State private var dragValue = 0.0
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                
                BackgroundOrange()
                
                VStack {
                    
                    Text("Игра для компании")
                        .modifiedText(size: smallTitle)
                    
                    Text("БОМБА")
                        .modifiedText(size: largeTitle)
                    
                    Image("bomb")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageWidth)
                        .scaleEffect(isTapped ? scaleEffectStart : scaleEffectEnd)
                        .rotationEffect(Angle(degrees: tapCount == maxTapCount ? maxDegrees : minDegrees))
                        .offset(y: isTapped ? startOffset : endOffset)
                        .animation(.spring(response: response, dampingFraction: dampingFriction), value: isTapped)
                        .onTapGesture {
                            tapped()
                        }
                    
                    Spacer()

                    NavigationLink {
                        GameView()
                    } label: {
                        MainButton(title: "Старт игры")
                    }
                    Button {
                        
                    } label: {
                        MainButton(title: "Категории")
                    }
                }
                .mainShadow()
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                            SettingsView(vm: vm)
                        } label: {
                            SettingsButton()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation(.spring()) {
                                isShowSheet.toggle()
                            }
                        } label: {
                            MainHelpButton()
                        }
                    }
                }
                MainHelpSheet()
                    .cornerRadius(cornerRadius)
                    .mainShadow()
                    .animateSheet(showHelp: $isShowSheet, dragValueY: $dragValue)
            }
        }
    }
    
    private func tapped() {
        impactHeavy.impactOccurred()
        isTapped = true
        tapCount += 1
        if tapCount == 7 {
            tapCount = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                isTapped = false
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm: MainViewModel())
    }
}
