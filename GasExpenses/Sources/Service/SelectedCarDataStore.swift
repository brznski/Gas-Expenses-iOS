//
//  SelectedCarDataStore.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

struct SelectedCarDataStore: SelectedCarDataStoreProtocol {
    func getSelectedCar() -> Car {
        //        if let cachedData = cache.getSelecetdCar()
        // if let dataFromCoreData
        // do network request

        return Car(name: "My Subaru",
                   brand: "Subaru",
                   model: "Impreza",
                   refuels: [
                    .init(date: .now, mileage: 250000.0, fuelAmount: 300.0, costPerUnit: 3.50),
                    .init(date: .now, mileage: 250150.3, fuelAmount: 200.0, costPerUnit: 3.60),
                    .init(date: Date(timeIntervalSince1970: 1678470122), mileage: 251300.3, fuelAmount: 60, costPerUnit: 3.40)
                   ])
    }
}
