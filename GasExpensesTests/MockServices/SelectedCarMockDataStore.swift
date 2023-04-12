//
//  SelectedCarMockDataStore.swift
//  GasExpensesTests
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

final class MockCarService: CarServiceProtocol {
    private let cars = [
        Car(name: "My Subaru",
                   brand: "Subaru",
                   model: "Impreza",
                   refuels: [
                    .init(date: .now, mileage: 164900.0, fuelAmount: 20.0, costPerUnit: 3.60),
                    .init(date: .now, mileage: 165000.0, fuelAmount: 10.0, costPerUnit: 3.60),
                    .init(date: .now, mileage: 165100.3, fuelAmount: 7, costPerUnit: 3.60)
                   ],
                   fuelType: .pb95,
                   isFavourite: true)
    ]

    func getCars() -> [Car] {
        return cars
    }

    func getFavouriteCar() -> Car? {
        return cars.first { $0.isFavourite }
    }
}
