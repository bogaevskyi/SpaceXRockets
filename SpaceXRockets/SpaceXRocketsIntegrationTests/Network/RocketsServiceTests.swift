//
//  RocketsServiceTests.swift
//  SpaceXRocketsIntegrationTests
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

@testable import SpaceXRockets
import Combine
import XCTest

class RocketsServiceTests: XCTestCase {
    let baseURL = URL(string: "https://api.spacexdata.com/v3")!
    let expectationTimeout: TimeInterval = 2
    
    var rocketsService: RocketsNetworkService!
    var cancellable: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        let httpClient = HttpClient(baseURL: baseURL)
        rocketsService = RocketsNetworkService(network: httpClient)
        cancellable = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        rocketsService = nil
        cancellable = nil
        
        super.tearDown()
    }

    func testFetchRocketsListSuccessful() {
        // Given
        let expect = expectation(description: "expectation of fetchRocketsList")
        var models: [RocketsListItemResponse]?
        var error: Error?
            
        // When
        rocketsService.fetchRocketsList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                error = completion.error
                expect.fulfill()
            }, receiveValue: { value in
                models = value
            })
            .store(in: &cancellable)
        
        wait(for: [expect], timeout: expectationTimeout)
        
        // Then
        XCTAssertNotNil(models)
        XCTAssertNil(error)
    }
    
    func testfetchRocketByIdSuccessful() {
        // Given
        let rocketId = "falcon9"
        let expect = expectation(description: "expectation of fetchRocketsList")
        var model: RocketResponse?
        var error: Error?
            
        // When
        rocketsService.fetchRocket(byId: rocketId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                error = completion.error
                expect.fulfill()
            }, receiveValue: { value in
                model = value
            })
            .store(in: &cancellable)
        
        wait(for: [expect], timeout: expectationTimeout)
        
        // Then
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.rocketId, rocketId)
        XCTAssertNil(error)
    }
}

extension Subscribers.Completion {
    var error: Error? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}
