//
//  Color + ext.swift
//  Bomb
//
//  Created by Лилия Феодотова on 07.08.2023.
//

import Foundation
import SwiftUI

extension Color {
    #warning("return избыточен и не нужен в однострочных выражениях")
    static var mainBackground: Color {
        return Color(red: 1.00, green: 0.82, blue: 0.37, opacity: 1)
    }
    static var mainViewButton: Color {
        return Color(red: 0.96, green: 0.96, blue: 0.93, opacity: 1)
    }
    static var categoryCellBg: Color {
        return Color(red: 0.92, green: 0.91, blue: 0.86, opacity: 1)
    }
    static var primaryTextColor: Color {
        return Color(red: 0.24, green: 0.23, blue: 0.23, opacity: 1)
    }
    static var secondaryTextColor: Color {
        return mainViewButton
    }
}
