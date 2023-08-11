//
//  Settings.swift
//  Bomb
//
//  Created by Илья Шаповалов on 11.08.2023.
//

import Foundation

struct Settings: Codable, Equatable {
    var duration: Duration = .middle
    var backgroundMelody: Melody = .melody1
    var tickSound: Melody = .melody1
    var explosionSound: Melody = .melody1
    var vibrationEnabled: Bool = true
    var questionsEnabled: Bool = true
}

extension Settings {
    //MARK: - Game duration
    enum Duration: Identifiable, Codable, CaseIterable {
        case short
        case middle
        case long
        case random
        
        var title: String {
            switch self {
            case .short: return "Короткое"
            case .middle: return "Среднее"
            case .long: return "Длинное"
            case .random: return "Случайное"
            }
        }
        
        var duration: Int {
            switch self {
            case .short: return 15
            case .middle: return 30
            case .long: return 45
            case .random: return [15, 30, 45].randomElement()!
            }
        }
        
        var id: String {
            title
        }
    }
    
    //MARK: - Melody
    enum Melody: Int, Codable, CaseIterable, Identifiable {
        case melody1
        case melody2
        case melody3
        
        var title: String {
            switch self {
            case .melody1: return "Мелодия 1"
            case .melody2: return "Мелодия 2"
            case .melody3: return "Мелодия 3"
            }
        }
        
        var id: Int {
            rawValue
        }
    }
}
