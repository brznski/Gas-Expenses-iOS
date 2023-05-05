//
//  SelectedCarMockDataStore.swift
//  GasExpensesTests
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

final class MockCarService: CarServiceProtocol {
    func setFavouriteCar(carID: Int) async throws {}

    func addCar(_ car: Car) async throws {

    }

    func getAllCars() async throws -> [Car] {
        return cars
    }

    private let cars = [
        Car(id: 1, name: "My Subaru",
            brand: "Subaru",
            model: "Impreza",
            refuels: [
            ],
            fuelType: .pb95,
            isFavourite: true,
            imageBase64: "")
    ]

    func getCars() -> [Car] {
        return cars
    }

    func getFavouriteCar() -> Car? {
        return cars.first { $0.isFavourite }
    }
}
