//
//  RocketsListItemViewModel.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Foundation

struct RocketsListItemViewModel {
    enum RateBadge {
        case green
        case orange
        case red
    }
    
    let name: String
    let date: String
    let rateBadge: RateBadge
    
    init(_ dataModel: RocketsListItemResponse) {
        self.name = dataModel.rocketName
        self.date = DateFormatter.mediumDateFormatter.string(from: dataModel.firstFlightDate)
        self.rateBadge = RateBadge(successRate: dataModel.successRate)
    }
}

extension RocketsListItemViewModel.RateBadge {
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
