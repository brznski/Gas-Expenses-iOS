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
        
        guard twoLastRefilsArray.count == 2 else { return 0 }
        
        let lastRefill = twoLastRefilsArray[1]
        let beforeLastRefill = twoLastRefilsArray[0]
        let distanceDriven = lastRefill.mileage - beforeLastRefill.mileage
        
        return (lastRefill.fuel * 100) / distanceDriven
    }
    
    func distanceDifferenceSinceLast() -> Double {
        let twoLastRefilsArray = refuels.suffix(2)
        
        guard twoLastRefilsArray.count == 2 else { return 0 }
        let lastRefill = twoLastRefilsArray[1]
        let beforeLastRefill = twoLastRefilsArray[0]
        
        return lastRefill.mileage - beforeLastRefill.mileage
    }
}
