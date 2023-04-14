//
//  Car.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct Refuel: Identifiable {
    let id = UUID()
    let date: Date
    let mileage: Double
    let fuelAmount: Double
    let costPerUnit: Double
}

struct Car: Identifiable {
    let id = UUID()
    let name: LocalizedStringKey
    let brand: String
    let model: String
    let refuels: [Refuel]
    let fuelType: FuelTypes
    let isFavourite: Bool

    func averageFuelConsumptionSinceLast() -> Double {
        let twoLastRefilsArray = refuels.suffix(2)

        let lastRefill = twoLastRefilsArray.last
        let beforeLastRefill = twoLastRefilsArray.first

        guard twoLastRefilsArray.count == 2,
              let lastRefill,
              let beforeLastRefill else { return 0 }
        let distanceDriven = lastRefill.mileage - beforeLastRefill.mileage

        return (lastRefill.fuelAmount * 100) / distanceDriven
    }

    func distanceDifferenceSinceLast() -> Double {
        let twoLastRefilsArray = refuels.suffix(2)

        let lastRefill = twoLastRefilsArray.last
        let beforeLastRefill = twoLastRefilsArray.first

        guard twoLastRefilsArray.count == 2,
              let lastRefill,
              let beforeLastRefill else { return 0 }

        return lastRefill.mileage - beforeLastRefill.mileage
    }

    func fuelConsumptionDifferenceSinceLast() -> Double {
        let lastFuelConsumption = averageFuelConsumptionSinceLast()

        let beforeLastRefill = refuels[refuels.count - 2]
        let beforeBeforeLastRefill = refuels[refuels.count - 3]

        let distanceDriven = beforeLastRefill.mileage - beforeBeforeLastRefill.mileage

        return lastFuelConsumption - ((beforeLastRefill.fuelAmount * 100) / distanceDriven)
    }

    func gasPerUnitPriceSinceLast() -> Double {
        let twoLastRefuels = refuels.suffix(2)

        let lastRefill = twoLastRefuels.last
        let beforeLastRefill = twoLastRefuels.first

        guard lastRefill != nil, beforeLastRefill != nil else { return 0 }

        return lastRefill!.costPerUnit - beforeLastRefill!.costPerUnit
    }
}
