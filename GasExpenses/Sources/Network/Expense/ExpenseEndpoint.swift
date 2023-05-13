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
    var payload: [String: Any] {
        ["carID": carID]
    }
    var accessToken: String

    let carID: String
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
            "expenseType": expense.expenseType.rawValue,
            "longitude": expense.longitude as Any,
            "latitude": expense.latitude as Any,
            "comment": expense.comment as Any,
            "documentBase64": expense.documentBase64 as Any
        ]
    ]
    }
    var accessToken: String

    let carID: String
    let expense: Expense
}

struct EditExpenseEndpoint: BackendEndpoint {
    let carID: String
    let expense: Expense
    
    var path: String = "expense/edit"
    var method: HTTPMethod = .PUT
    var payload: [String: Any] { [
        "carID": carID,
        "expense": [
            "id": expense.id,
            "amount": expense.amount,
            "title": expense.title,
            "date": expense.date,
            "expenseType": expense.expenseType.rawValue,
            "longitude": expense.longitude as Any,
            "latitude": expense.latitude as Any,
            "comment": expense.comment as Any,
            "documentBase64": expense.documentBase64 as Any
        ]
    ]
    }
    var accessToken: String
}

struct DeleteExpenseEndpoint: BackendEndpoint {
    let expenseID: Int

    var path: String = "expense/delete"
    var method: HTTPMethod = .DELETE
    var payload: [String: Any] { ["expenseID": expenseID] }
    var accessToken: String
}
