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
    var payload: [String: Any] = ["carID": "16"]
    var accessToken: String
}

struct AddExpenseEndpoint: BackendEndpoint {
    var path: String = "expense/add"
    var method: HTTPMethod = .POST
    var payload: [String: Any] { [
        "carID": carID,
        "expense": [
            "amount": expense.amount,
            "title": expense.title,
            "date": expense.date,
            "expenseType": expense.expenseType.rawValue
        ]
    ]
    }
    var accessToken: String

    let carID: String
    let expense: Expense
}
