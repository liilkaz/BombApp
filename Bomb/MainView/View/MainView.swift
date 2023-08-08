//
//  MainView.swift
//  Bomb
//
//  Created by dsm 5e on 07.08.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var showSettings: Bool = false
    @State private var isShowSheet: Bool = false
    @State private var isTapped: Bool = false
    @State private var tapCount: Int = 0
    @State private var dragValue = 0.0
    @StateObject var vm = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                
                Color.mainBackground
                    .ignoresSafeArea()
                
                Image("bgOrange")
                    .resizable()
                    .scaledToFit()
                    .offset(x: -30)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("Игра для компании")
                        .foregroundStyle(Color.secondaryTextColor)
                        .font(.system(size: 36, weight: .heavy, design: .rounded))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    
                    Text("БОМБА")
                        .foregroundStyle(Color.secondaryTextColor)
                        .font(.system(size: 48, weight: .heavy, design: .rounded))
                        .minimumScaleFactor(0.7)
                    
                    Image("bomb")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .scaleEffect(isTapped ? 1.1 : 1.0)
                        .rotationEffect(Angle(degrees: tapCount == 6 ? 360 : 0))
                        .offset(y: isTapped ? -10 : 0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.5))
                        .onTapGesture {
                            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
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
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Старт Игры")
                            .foregroundStyle(Color.primaryTextColor)
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.mainViewButton)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Категории")
                            .foregroundStyle(Color.primaryTextColor)
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.mainViewButton)
                            .cornerRadius(10)
                    }
                }
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                            SettingsView(vm: vm)
                                .navigationBarBackButtonHidden()
                        } label: {
                            Image("settings")
                            
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation(.bouncy) {
                                isShowSheet.toggle()
                            }
                        } label: {
                            Image("helpRed")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                    }
                }
                MainHelpSheet()
                    .cornerRadius(20)
                    .shadow(radius: 4)
                    .animateSheet(showHelp: $isShowSheet, dragValueY: $dragValue)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm: MainViewModel())
    }
}
