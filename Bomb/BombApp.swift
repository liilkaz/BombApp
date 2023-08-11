//
//  BombApp.swift
//  Bomb
//
//  Created by Лилия Феодотова on 06.08.2023.
//

import SwiftUI

@main
struct BombApp: App {
    @StateObject var dataProvider = DataProvider()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(dataProvider)
        }
    }
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        UINavigationBar.appearance().standardAppearance = appearance
    }
}
