//
//  CarDataSource.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import Foundation

protocol CarServiceProtocol {
    func getCars() -> [Car]
    func getFavouriteCar() -> Car?
}

final class CarDataSource: CarServiceProtocol {
    private var cars: [Car] = [
        .init(name: "My Subaru",
                   brand: "Subaru",
                   model: "Impreza",
                   refuels: [
                    .init(date: .now, mileage: 250000.0, fuelAmount: 300.0, costPerUnit: 3.50),
                    .init(date: .now, mileage: 250150.3, fuelAmount: 200.0, costPerUnit: 3.60),
                    .init(date: Date(timeIntervalSince1970: 1678470122), mileage: 251300.3, fuelAmount: 60, costPerUnit: 3.40)
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
