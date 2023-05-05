//
//  CarDetailsViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import Foundation

final class CarDetailsViewModel {
    private let carService: CarServiceProtocol

    init(carService: CarServiceProtocol) {
        self.carService = carService
    }

    func deleteCar(carID: Int) {
        Task {
            try await carService.deleteCar(carID: carID)
        }
    }
}
