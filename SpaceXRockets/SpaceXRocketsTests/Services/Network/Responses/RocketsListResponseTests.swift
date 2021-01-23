//
//  RocketsListResponseTests.swift
//  SpaceXRocketsTests
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

@testable import SpaceXRockets
import XCTest

class RocketsListResponseTests: XCTestCase {
    func testDecodeRocketsListItemResponseFromJSON() throws {
        let items: [RocketsListItemResponse] = try JSONUtils.model(fromFile: "RocketsListResponse")
        XCTAssertEqual(items.count, 4)
    }
}
