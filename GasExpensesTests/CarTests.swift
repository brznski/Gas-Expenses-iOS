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
        return Car(id: 1, name: "My Subaru",
                   brand: "Subaru",
                   model: "Impreza",
                   refuels: [
                    .init(id: 1, date: "2023-04-18T00:00:00.000+00:00", mileage: 164900.0, fuelAmount: 20.0, costPerUnit: 3.60),
                    .init(id: 2, date: "2023-04-18T00:00:00.000+00:00", mileage: 165000.0, fuelAmount: 10.0, costPerUnit: 3.60),
                    .init(id: 3, date: "2023-04-18T00:00:00.000+00:00", mileage: 165100.0, fuelAmount: 7, costPerUnit: 3.60)
                   ],
                   fuelType: .pb95,
                   isFavourite: true)
    }
}
