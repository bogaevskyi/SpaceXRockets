//
//  RecketDetailsContentViewModel.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 25.01.2021.
//

import Combine
import Foundation
import UIKit

class RecketDetailsContentViewModel: ObservableObject {
    enum ActiveStatus {
        case active
        case notActive
        
        init(_ boolValue: Bool) {
            self = boolValue ? .active : .notActive
        }
        
        var stringRepresentation: String {
            switch self {
            case .active: return "Active"
            case .notActive: return "Not Active"
            }
        }
    }
    
    let recketName: String
    let imageURL: URL
    let firstFlightDate: String
    let costPerLaunch: String
    let activeStatus: ActiveStatus
    let country: String
    let description: String
    let rateBadge: String
    let wikipediaURL: URL
    
    init(_ dataModel: RocketResponse) {
        self.recketName = dataModel.rocketName
        self.imageURL = dataModel.coverImageURL
        self.firstFlightDate = DateFormatter.mediumDateFormatter.string(from: dataModel.firstFlightDate)
        self.costPerLaunch = NumberFormatter.currencyFormatterUS.string(for: dataModel.costPerLaunch) ?? ""
        self.activeStatus = ActiveStatus(dataModel.isActive)
        self.country = dataModel.country
        self.description = dataModel.description
        self.rateBadge = RateBadge(successRate: dataModel.successRate).stringRepresentation
        self.wikipediaURL = dataModel.wikipediaURL
    }
}
