//
//  LandingPageViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

final class LandingPageViewModel: ObservableObject {
    private let carService = CarService()
    @Published var selectedCar: Car?
    @Published var cars: [Car] = []

    func prepareModels() {
        Task {
            await getCars()
            prepareSelectedCars()
        }
    }

    func getCars() async {
        do {
            let response = try await carService.getAllCars()
            DispatchQueue.main.async {
                self.cars = response
            }
        } catch {
            
        }
    }
    
    func prepareSelectedCars() {
        DispatchQueue.main.async { [weak self] in
            self?.selectedCar = self?.cars.first { $0.isFavourite }
        }
    }
}
