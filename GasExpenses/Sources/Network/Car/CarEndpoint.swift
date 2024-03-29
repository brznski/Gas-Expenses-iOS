//
//  CarEndpoint.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 24/04/2023.
//

import Foundation

struct GetAllCarsEndpoint: BackendEndpoint {
    var path: String = "car/getAll"
    var method: HTTPMethod = .GET
    var payload: [String: Any] = [:]
    var accessToken: String
}

struct AddNewCarEndpoint: BackendEndpoint {
    let car: Car

    var path: String = "car/add"
    var method: HTTPMethod = .POST
    var payload: [String: Any] {
        [
            "name": car.name,
            "brand": car.brand,
            "model": car.model,
            "refuels": car.refuels,
            "expenses": [],
            "fuelType": FuelTypes.pb95.rawValue,
            "isFavourite": car.isFavourite,
            "imageBase64": car.imageBase64 as Any,
            "insuranceExpiration": car.insuranceExpiration,
            "technicalCheckupExpiration": car.technicalCheckupExpiration
        ]
    }

    var accessToken: String
}

struct EditCarEndpoint: BackendEndpoint {
    let car: Car
    var path: String = "car/edit"
    var method: HTTPMethod = .PUT
    var payload: [String: Any] {
        [
            "id": car.id,
            "name": car.name,
            "brand": car.brand,
            "model": car.model,
            "refuels": car.refuels,
            "expenses": [],
            "fuelType": FuelTypes.pb95.rawValue,
            "isFavourite": car.isFavourite,
            "imageBase64": car.imageBase64 as Any,
            "insuranceExpiration": car.insuranceExpiration,
            "technicalCheckupExpiration": car.technicalCheckupExpiration
        ]
    }
    var accessToken: String
}

struct DeleteCarEndpoint: BackendEndpoint {
    let carID: Int

    var path: String = "car/delete"
    var method: HTTPMethod = .DELETE
    var payload: [String: Any] {
        [
            "carID": carID
        ]
    }
    var accessToken: String
}

struct SetFavouriteCarEndpoint: BackendEndpoint {
    let carID: Int

    var path: String = "car/change-favourite"
    var method: HTTPMethod = .POST
    var payload: [String: Any] {
        [
            "carID": carID
        ]
    }
    var accessToken: String
}
