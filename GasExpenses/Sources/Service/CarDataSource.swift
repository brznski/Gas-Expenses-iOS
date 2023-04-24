//
//  CarDataSource.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import Foundation

final class CarDataSource {
    private let carService: CarServiceProtocol
    private var cars: [Car] = []

    init(carService: CarServiceProtocol) {
        self.carService = carService
    }

    func getCars() async throws -> [Car] {
        let cars = try await carService.getAllCars()
        return cars
    }

    func getFavouriteCar() -> Car? {
        return cars.first { $0.isFavourite }
    }
}
