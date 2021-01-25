//
//  RateBadge.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Foundation

enum RateBadge {
    case green
    case orange
    case red
}

extension RateBadge {
    init(successRate: Int) {
        switch successRate {
            case Int.min...29: self = .red
            case 30...59: self = .orange
            default: self = .green
        }
    }
    
    var stringRepresentation: String {
        switch self {
            case .green: return "🟢"
            case .orange: return "🟠"
            case .red: return "🔴"
        }
    }
}
