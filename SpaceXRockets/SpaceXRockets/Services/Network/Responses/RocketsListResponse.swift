//
//  RocketsListResponse.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

import Foundation

struct RocketsListItemResponse: Decodable {
    let rocketId: String
    let rocketName: String
    let images: [URL]
    let successRate: Int
    let firstFlightDate: Date
    
    enum CodingKeys: String, CodingKey {
        case rocketId = "rocket_id"
        case rocketName = "rocket_name"
        case images = "flickr_images"
        case successRate = "success_rate_pct"
        case firstFlightDate = "first_flight"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rocketId = try container.decode(String.self, forKey: .rocketId)
        rocketName = try container.decode(String.self, forKey: .rocketName)
        images = try container.decode([URL].self, forKey: .images)
        successRate = try container.decode(Int.self, forKey: .successRate)
        
        let dateString = try container.decode(String.self, forKey: .firstFlightDate)
        guard let date = DateFormatter.rocketResponseDateFormatter.date(from: dateString) else {
            throw SpaceXError.parsing(description: "RocketsListItemResponse: Unable to build date from \(dateString)")
        }
        firstFlightDate = date
    }
}
