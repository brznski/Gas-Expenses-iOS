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
    private let cache = Cache.shared

    init(carService: CarServiceProtocol) {
        self.carService = carService
    }

    func getCars() async throws -> [Car] {
        if let cachedData = cache.getCacheEntry(key: "cars", object: [Car].self) {
            return cachedData
        }

        let cars = try await carService.getAllCars()
        cache.cache(object: cars, key: "cars")
        return cars
    }

    func getFavouriteCar() -> Car? {
        return cars.first { $0.isFavourite }
    }
}
