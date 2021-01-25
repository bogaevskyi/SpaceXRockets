//
//  NumberFormatter+Utils.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 25.01.2021.
//

import Foundation

extension NumberFormatter {
    static var currencyFormatterUS: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
}
