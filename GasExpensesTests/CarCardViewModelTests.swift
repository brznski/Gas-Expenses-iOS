//
//  CarCardViewModelTests.swift
//  GasExpensesTests
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import XCTest

final class CarCardViewModelTests: XCTestCase {
    func test_shouldShowFormattedMileage() {
        let sut = makeSUT()
        
        let mileageRow = sut.carInfoRows.first { $0.iconName == "gauge" }
        
        XCTAssertEqual(mileageRow?.text, "165,100.3 km")
    }
    
    func makeSUT() -> CarCardViewModel {
        let carModel = Car(name: "My Subaru",
                           brand: "Subaru",
                           model: "Impreza",
                           refuels: [
                            (Date.now, 165000, 20),
                            (Date.now, 165100.345, 7)
                           ])
        
        return .init(model: carModel)
    }
}
