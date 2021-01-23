//
//  DateFormatter+Utils.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

import Foundation

extension DateFormatter {
    /// "yyyy-MM-dd"
    static let rocketResponseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.defaultDate = Date()
        return formatter
    }()
}
