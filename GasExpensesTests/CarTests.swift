//
//  CarTests.swift
//  GasExpensesTests
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import XCTest

final class CarTests:XCTestCase {
    
    func test_shouldCalculateAverageFuelConsumption() {
        let model = makeSUT()
        
        let fuelConsumption = model.averageFuelConsumptionSinceLast()
        
        XCTAssertEqual(fuelConsumption, 7.0)
    }
    
    func makeSUT() -> Car {
        return Car(name: "My Subaru",
                   brand: "Subaru",
                   model: "Impreza",
                   refuels: [
                    (Date.now, 165000, 20),
                    (Date.now, 165100, 7)
                   ])
    }
}
