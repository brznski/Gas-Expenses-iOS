//
//  CarDataSource.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import Foundation

final class CarDataSource: ObservableObject {
    private let carService: CarServiceProtocol
    @Published var selectedCar: Car?
    @Published var cars: [Car] = []
    private let cache = Cache.shared

    init(carService: CarServiceProtocol) {
        self.carService = carService
    }

    func getCars() async throws -> [Car] {
        if let cachedData = cache.getCacheEntry(key: "cars", object: [Car].self) {
            setSelectedCar()
            return cachedData
        }

        let cars = try await carService.getAllCars()
        cache.cache(object: cars, key: "cars")

        DispatchQueue.main.async {
            self.cars = cars
        }

        setSelectedCar()

        return cars
    }

    func getFavouriteCar() -> Car? {
        return cars.first { $0.isFavourite }
    }

    private func setSelectedCar() {
        DispatchQueue.main.async { [weak self] in
            self?.selectedCar = self?.cars.first { $0.isFavourite }
        }
    }
}
