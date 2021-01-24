//
//  SpaceXError.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

import Alamofire

enum SpaceXError: Error {
    case parsing(description: String)
    case network(description: String)
    case unknown(description: String)
}

extension SpaceXError {
    init(_ error: Error) {
        switch error {
        case let afError as AFError:
            self = .network(description: afError.localizedDescription)
        default:
            self = .unknown(description: error.localizedDescription)
        }
    }
}
