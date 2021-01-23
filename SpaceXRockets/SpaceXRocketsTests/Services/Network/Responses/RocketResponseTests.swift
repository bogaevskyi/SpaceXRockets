//
//  RocketResponseTests.swift
//  SpaceXRocketsTests
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

@testable import SpaceXRockets
import XCTest

class RocketResponseTests: XCTestCase {
    func testDecodeRocketResponseFromJSON() {
        XCTAssertNoThrow(try JSONUtils.model(fromFile: "OneRocketResponse") as RocketResponse)
    }
}
