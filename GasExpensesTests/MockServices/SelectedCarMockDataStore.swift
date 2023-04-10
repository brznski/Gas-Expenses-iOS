//
//  SelectedCarMockDataStore.swift
//  GasExpensesTests
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

final class SelectedCarMockDataStore: SelectedCarDataStoreProtocol {
    func getSelectedCar() -> Car {
        return Car(name: "My Subaru",
                   brand: "Subaru",
                   model: "Impreza",
                   refuels: [
                    (Date.now, 164900, 20, costPerUnit: 3.60),
                    (Date.now, 165000, 10, costPerUnit: 3.60),
                    (Date.now, 165100.3, 7, costPerUnit: 3.60)
                   ])
    }
}
