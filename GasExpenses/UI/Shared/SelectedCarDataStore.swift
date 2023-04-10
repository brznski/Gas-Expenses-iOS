//
//  SelectedCarDataStore.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

struct SelectedCarDataStore {
    func getSelectedCar() -> Car {
        //        if let cachedData = cache.getSelecetdCar()
        // if let dataFromCoreData
        // do network request
        
        return Car(name: "My Subaru",
                   brand: "Subaru",
                   model: "Impreza",
                   refuels: [
                    (.now, 250000, 300, costPerUnit: 3.50),
                    (.now, 250150.3, 200, costPerUnit: 3.60),
                    (Date(timeIntervalSince1970: 1678470122), 251300.3, 60, costPerUnit: 3.40)
                   ])
    }
}
