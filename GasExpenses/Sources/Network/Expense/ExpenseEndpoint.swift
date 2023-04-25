//
//  ExpenseEndpoint.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 25/04/2023.
//

import Foundation

struct GetAllExpensesEndpoint: BackendEndpoint {
    var path: String = "expense/getAll"
    var method: HTTPMethod = .GET
    var payload: [String : Any] = ["carID": "16"]
    var accessToken: String
}
