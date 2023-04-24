//
//  LandingPageViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

final class LandingPageViewModel: ObservableObject {
    private let carService = CarService()
    @Published var cars: [Car] = []

    func getCars() async -> [Car] {
        do {
            let response = try await carService.getAllCars()
            DispatchQueue.main.async {
                self.cars = response
            }
            return cars
        } catch {
            return []
        }
    }
}
