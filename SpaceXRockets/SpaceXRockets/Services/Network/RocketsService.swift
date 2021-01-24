//
//  RocketsService.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Combine

protocol RocketsService: AnyObject {
    func fetchRocketsList() -> AnyPublisher<[RocketsListItemResponse], SpaceXError>
    func fetchRocket(byId rocketId: String) -> AnyPublisher<RocketResponse, SpaceXError>
}

final class RocketsNetworkService {
    let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
}

extension RocketsNetworkService: RocketsService {
    func fetchRocketsList() -> AnyPublisher<[RocketsListItemResponse], SpaceXError> {
        network
            .performRequest(RocketsRouter.getList)
            .mapError { SpaceXError($0) }
            .eraseToAnyPublisher()
    }
    
    func fetchRocket(byId rocketId: String) -> AnyPublisher<RocketResponse, SpaceXError> {
        network
            .performRequest(RocketsRouter.getOne(rocketId: rocketId))
            .mapError { SpaceXError($0) }
            .eraseToAnyPublisher()
    }
}
