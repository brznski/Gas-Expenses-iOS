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
    var payload: [String : Any] = [:]
    var accessToken: String
}

struct AddNewCarEndpoint: BackendEndpoint {
    var path: String = "car/add"
    var method: HTTPMethod = .POST
    var payload: [String : Any] = [:]
    var accessToken: String
}

struct EditCarEndpoint: BackendEndpoint {
    var path: String = "car/edit"
    var method: HTTPMethod = .PUT
    var payload: [String : Any] = [:]
    var accessToken: String
}

struct DeleteCarEndpoint: BackendEndpoint {
    var path: String = "car/delete"
    var method: HTTPMethod = .DELETE
    var payload: [String : Any] = [:]
    var accessToken: String
}
