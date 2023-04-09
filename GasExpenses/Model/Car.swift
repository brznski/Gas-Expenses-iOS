//
//  Car.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct Car {
    let name: LocalizedStringKey
    let brand: String
    let model: String
    let refuels: [(date: Date, mileage: Double, fuel: Double)]
    
    func averageFuelConsumptionSinceLast() -> Double {
        let twoLastRefilsArray = refuels.suffix(2)
        
        let lastRefill = twoLastRefilsArray.last
        let beforeLastRefill = twoLastRefilsArray.first
        
        guard twoLastRefilsArray.count == 2,
              let lastRefill,
              let beforeLastRefill else { return 0 }
        let distanceDriven = lastRefill.mileage - beforeLastRefill.mileage
        
        return (lastRefill.fuel * 100) / distanceDriven
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
        
        return lastFuelConsumption - ((beforeLastRefill.fuel * 100) / distanceDriven)
    }
}
