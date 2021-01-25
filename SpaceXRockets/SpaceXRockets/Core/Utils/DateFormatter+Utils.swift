//
//  DateFormatter+Utils.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

import Foundation

extension DateFormatter {
    /// "yyyy-MM-dd"
    static var rocketResponseDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.defaultDate = Date()
        return formatter
    }
    
    /// A formatter of medium date style, eg. "Jan 24, 2021"
    static var mediumDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}
