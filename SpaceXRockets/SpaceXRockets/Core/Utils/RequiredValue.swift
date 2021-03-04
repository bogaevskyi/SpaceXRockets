//
//  RequiredValue.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 04.03.2021.
//

import Foundation

enum RequiredValue<Value> {
    enum RequiredValueError: Error {
        case failedToUnwrapValue
    }
    
    static func unwrap(_ value: Value?) throws -> Value {
        guard let value = value else {
            throw RequiredValueError.failedToUnwrapValue
        }
        return value
    }
}
