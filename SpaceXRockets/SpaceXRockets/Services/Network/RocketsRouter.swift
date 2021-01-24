//
//  RocketsRouter.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Alamofire

enum RocketsRouter: RequestRouter {
    case getList
    case getOne(rocketId: String)
    
    // MARK: - RequestRouter

    var httpMethod: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .getList: return "/rockets"
        case .getOne(let rocketId): return "/rockets/\(rocketId)"
        }
    }
}
