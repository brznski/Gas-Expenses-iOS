//
//  RefuelEndpoint.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 27/04/2023.
//

import Foundation

struct AddRefuelEndpoint: BackendEndpoint {
    var path: String = "refuel/add"
    var method: HTTPMethod = .POST
    var payload: [String: Any] { [
        "carID": "\(carID)",
        "refuel": [
            "date": refuel.date,
            "mileage": refuel.mileage,
            "fuelAmount": refuel.fuelAmount,
            "costPerUnit": refuel.costPerUnit
        ]
    ]
    }
    var accessToken: String

    let refuel: Refuel
    let carID: Int
}
