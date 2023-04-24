//
//  MockCar.swift
//  GasExpensesTests
//
//  Created by Michał Brzeziński on 24/04/2023.
//

import Foundation

extension Car {
    static func getMockCar() -> Car {
        Car(id: 1, name: "My Subaru",
                   brand: "Subaru",
                   model: "Impreza",
                   refuels: [
                    .init(id: 1, date: "2023-04-18T00:00:00.000+00:00", mileage: 164900.0, fuelAmount: 20.0, costPerUnit: 3.60),
                    .init(id: 2, date: "2023-04-18T00:00:00.000+00:00", mileage: 165000.0, fuelAmount: 10.0, costPerUnit: 3.60),
                    .init(id: 3, date: "2023-04-18T00:00:00.000+00:00", mileage: 165100.3, fuelAmount: 7, costPerUnit: 3.60)
                   ],
                   fuelType: .pb95,
                   isFavourite: true)
    }
}
