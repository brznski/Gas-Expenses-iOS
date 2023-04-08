//
//  CarDataSource.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import Foundation

final class CarDataSource {
    func getCars() -> [Car] {
        return []
    }
    
    func getCurrentCar() -> Car {
        return .init(name: "My car", brand: "Subaru", model: "Impreza", refuels: [])
    }
}
