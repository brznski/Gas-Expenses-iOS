//
//  SelectedCarMockDataStore.swift
//  GasExpensesTests
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

final class MockCarService: CarServiceProtocol {
    func deleteCar(carID: Int) async throws {}

    func setFavouriteCar(carID: Int) async throws {}

    func addCar(_ car: Car) async throws {}

    func editCar(car: Car) async throws {}

    func getAllCars() async throws -> [Car] {
        return cars
    }

    private let cars = [Car.mock]

    func getCars() -> [Car] {
        return cars
    }

    func getFavouriteCar() -> Car? {
        return cars.first { $0.isFavourite }
    }
}
