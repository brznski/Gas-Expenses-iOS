//
//  RefuelEndpoint.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 27/04/2023.
//

import Foundation

struct GetAllRefuelsEndpoint: BackendEndpoint {
    let carID: Int

    var path: String = "refuel/getAll"
    var method: HTTPMethod = .GET
    var payload: [String: Any] {
        [
            "carID": carID
        ]
    }
    var accessToken: String
}

struct AddRefuelEndpoint: BackendEndpoint {
    var path: String = "refuel/add"
    var method: HTTPMethod = .POST
    var payload: [String: Any] { [
        "carID": "\(carID)",
        "refuel": [
            "date": refuel.date,
            "mileage": refuel.mileage,
            "fuelAmount": refuel.fuelAmount,
            "costPerUnit": refuel.costPerUnit,
            "longitude": refuel.longitude,
            "latitude": refuel.latitude
        ]
    ]
    }
    var accessToken: String

    let refuel: Refuel
    let carID: Int
}
