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

    private let carService: CarServiceProtocol

    init(car: Car,
         carService: CarServiceProtocol) {
        self.model = car
        self.carService = carService
        prepareCarInfoRows()
    }

    func setFavouriteCar() {
        Task {
            try await carService.setFavouriteCar(carID: model?.id ?? -1)
        }
    }

    private func prepareCarInfoRows() {
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
