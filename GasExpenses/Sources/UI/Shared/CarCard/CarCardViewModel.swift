//
//  CarCardViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

final class CarCardViewModel: ObservableObject {
    @Published var model: Car?
    @Published var carInfoRows = [CarCardInfoRowConfiguration]()
    @Published var availableCars: [Car] = []

    init(car: Car) {
        self.model = car
    }

    func getSelectedCar() {

        if let model,
           model.refuels.count > 2 {
            configureOdometerRowInfo()
            configureGasCostRowInfo()
            carInfoRows.append(CarCardInfoRowConfiguration(iconName: "fuelpump.fill",
                                                           text: String(format: "%.2f l/100km", model.averageFuelConsumptionSinceLast()),
                                                           helpText: String(format: "%.2f l/100km", model.fuelConsumptionDifferenceSinceLast()),
                                                           isPositive: model.fuelConsumptionDifferenceSinceLast() < 0))
        }
    }

    func getCars() {
        Task {
            do {
                 let response = try await CarDataSource(carService: CarService()).getCars()

                DispatchQueue.main.async { [weak self] in
                    self?.availableCars = response
                }
            } catch {

            }
        }
    }

    private func configureOdometerRowInfo() {

        if let model,
           model.refuels.count > 2 {
            carInfoRows.append(CarCardInfoRowConfiguration(iconName: "gauge",
                                                           text: "\(model.refuels.last?.mileage.odometerString() ?? "") km",
                                                           helpText: "\(model.distanceDifferenceSinceLast().odometerString() ?? "") km",
                                                           isPositive: nil))
        }
    }

    private func configureGasCostRowInfo() {

        if let model,
           model.refuels.count > 2 {
            carInfoRows.append(CarCardInfoRowConfiguration(iconName: "dollarsign.circle",
                                                           text: "\(model.refuels.last?.costPerUnit.currencyString() ?? "") ",
                                                           helpText: "\(model.gasPerUnitPriceSinceLast().currencyString() ?? "")",
                                                           isPositive: model.gasPerUnitPriceSinceLast() < 0))
        }
    }
}

struct CacheTestKey: Codable {
    let name: String
    let age: Int
    let isDog: Bool
}
