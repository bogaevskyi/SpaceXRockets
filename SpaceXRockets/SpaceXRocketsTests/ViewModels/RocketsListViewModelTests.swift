//
//  RocketsListViewModelTests.swift
//  SpaceXRocketsTests
//
//  Created by Andrew Bohaevskiy on 25.01.2021.
//

@testable import SpaceXRockets
import XCTest

class RocketsListViewModelTests: XCTestCase {
    var mockRocketsService: MockRocketsService!
    var viewModel: RocketsListViewModel!
    
    override func setUp() {
        super.setUp()
        mockRocketsService = MockRocketsService()
        viewModel = RocketsListViewModel(rocketsService: mockRocketsService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRocketsService = nil
        super.tearDown()
    }

    // MARK: - Tests
    
    func testInitialLoadingState() {
        XCTAssertTrue(viewModel.isLoading)
    }
    
    func testFetchRocketsLoadingState() throws {
        // Given
        let items: [RocketsListItemResponse] = try JSONUtils.model(fromFile: "RocketsListResponse")
        mockRocketsService.fetchRocketsListStub = (response: items, error: nil)
        
        // When
        viewModel.fetchRockets()
        
        // Then
        XCTAssertTrue(mockRocketsService.isFetchRocketsListCalled)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testRecieveItemsWhenFetchRockets() throws {
        // Given
        let items: [RocketsListItemResponse] = try JSONUtils.model(fromFile: "RocketsListResponse")
        mockRocketsService.fetchRocketsListStub = (response: items, error: nil)
        
        // When
        viewModel.fetchRockets()
        
        // Then
        XCTAssertTrue(mockRocketsService.isFetchRocketsListCalled)
        XCTAssertFalse(viewModel.items.isEmpty)
        XCTAssertEqual(items.count, viewModel.items.count)
    }
}
