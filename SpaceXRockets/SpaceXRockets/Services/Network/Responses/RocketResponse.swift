//
//  RocketResponse.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

import Foundation

struct RocketResponse: Decodable {
    let rocketId: String
    let rocketName: String
    let coverImageURL: URL
    let successRate: Int
    let firstFlightDate: Date
    let isActive: Bool
    let costPerLaunch: Int
    let wikipediaURL: URL
    let country: String
    let description: String
}

extension RocketResponse {
    enum CodingKeys: String, CodingKey {
        case rocketId = "rocket_id"
        case rocketName = "rocket_name"
        case images = "flickr_images"
        case successRate = "success_rate_pct"
        case firstFlightDate = "first_flight"
        case isActive = "active"
        case costPerLaunch = "cost_per_launch"
        case wikipediaURL = "wikipedia"
        case country
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rocketId = try container.decode(String.self, forKey: .rocketId)
        rocketName = try container.decode(String.self, forKey: .rocketName)
        let images = try container.decode([URL].self, forKey: .images)
        coverImageURL = try RequiredValue.unwrap(images.first)
        successRate = try container.decode(Int.self, forKey: .successRate)
        
        let dateString = try container.decode(String.self, forKey: .firstFlightDate)
        guard let date = DateFormatter.rocketResponseDateFormatter.date(from: dateString) else {
            throw SpaceXError.parsing(description: "RocketResponse: Unable to build date from \(dateString)")
        }
        firstFlightDate = date
        isActive = try container.decode(Bool.self, forKey: .isActive)
        costPerLaunch = try container.decode(Int.self, forKey: .costPerLaunch)
        wikipediaURL = try container.decode(URL.self, forKey: .wikipediaURL)
        country = try container.decode(String.self, forKey: .country)
        description = try container.decode(String.self, forKey: .description)
    }
}
