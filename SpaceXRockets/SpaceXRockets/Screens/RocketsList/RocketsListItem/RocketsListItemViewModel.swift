//
//  RocketsListItemViewModel.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Foundation

struct RocketsListItemViewModel {
    let rocketId: String
    let name: String
    let date: String
    let rateBadge: String
    
    init(_ dataModel: RocketsListItemResponse) {
        self.rocketId = dataModel.rocketId
        self.name = dataModel.rocketName
        self.date = DateFormatter.mediumDateFormatter.string(from: dataModel.firstFlightDate)
        self.rateBadge = RateBadge(successRate: dataModel.successRate).stringRepresentation
    }
}
