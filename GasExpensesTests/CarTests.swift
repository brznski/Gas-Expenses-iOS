//
//  CarTests.swift
//  GasExpensesTests
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import XCTest

final class CarTests: XCTestCase {

    func test_shouldCalculateAverageFuelConsumption() {
        let model = makeSUT()

        let fuelConsumption = model.averageFuelConsumptionSinceLast()

        XCTAssertEqual(fuelConsumption, 7.0)
    }

    func test_shouldCalculateDifferenceSinceLast() {
        let model = makeSUT()

        let differenceSinceLast = model.distanceDifferenceSinceLast()

        XCTAssertEqual(differenceSinceLast, 100)
    }

    func test_shouldCalculateFuelDifferenceSinceLast() {
        let model = makeSUT()

        let differenceSinceLast = model.fuelConsumptionDifferenceSinceLast()

        XCTAssertEqual(differenceSinceLast, -3)
    }

    func test_shouldBePositiveIfValueIsPositive() {
        _ = makeSUT()
    }

    func makeSUT() -> Car {
        return MockCarService().getCars().first!
    }
}
