//
//  LandingPageViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation
import SwiftUI

final class LandingPageViewModel: ObservableObject {
    @ObservedObject var carDataSource: CarDataSource
    @Published var selectedCar: Car?
    @Published var cars: [Car] = []
    @EnvironmentObject var carDataSource2: CarDataSource

    init(carDataSource: CarDataSource) {
        self.carDataSource = carDataSource
    }

    func prepareModels() {
        Task {
            await getCars()
        }
    }

    func getCars() async {
        do {
            cars = try await carDataSource.getCars()
        } catch {

        }
    }

    func prepareSelectedCars() {
        DispatchQueue.main.async { [weak self] in
            self?.selectedCar = self?.cars.first { $0.isFavourite }
        }
    }
}
