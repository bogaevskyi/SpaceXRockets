//
//  MockRocketsService.swift
//  SpaceXRocketsTests
//
//  Created by Andrew Bohaevskiy on 25.01.2021.
//

@testable import SpaceXRockets
import Foundation
import Combine

class MockRocketsService: RocketsService {
    var isFetchRocketsListCalled = false
    var fetchRocketsListStub: (response: [RocketsListItemResponse]?, error: SpaceXError?)?
    
    func fetchRocketsList() -> AnyPublisher<[RocketsListItemResponse], SpaceXError> {
        isFetchRocketsListCalled = true
        if let stub = fetchRocketsListStub, let response = stub.response {
            return Just(response)
                .setFailureType(to: SpaceXError.self)
                .eraseToAnyPublisher()
        } else {
            return Just([] as [RocketsListItemResponse])
                .setFailureType(to: SpaceXError.self)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchRocket(byId rocketId: String) -> AnyPublisher<RocketResponse, SpaceXError> {
        Fail(error: SpaceXError.unknown(description: "description"))
            .eraseToAnyPublisher()
    }
}
