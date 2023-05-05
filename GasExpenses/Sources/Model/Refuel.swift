//
//  Refuel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import Foundation

struct Refuel: Identifiable, Codable {
    let id: Double
    let date: String
    let mileage: Double
    let fuelAmount: Double
    let costPerUnit: Double
    let latitude: Double
    let longitude: Double
}
