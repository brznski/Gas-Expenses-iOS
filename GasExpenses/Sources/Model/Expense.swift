//
//  Expense.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import Foundation

struct Expense: Identifiable, Codable {
    let id: Int
    let amount: Double
    let comment: String?
    let title: String
    let date: String
    let expenseType: ExpenseType
    let latitude: Double?
    let longitude: Double?
    let documentBase64: String?
}

extension Expense {
    static let mock = Expense(id: 3,
                              amount: 350.3,
                              comment: "This is a payment for clutch and gearbox",
                              title: "Fuel",
                              date: "2023-05-16 02:00:00.000000",
                              expenseType: .wash,
                              latitude: 54,
                              longitude: 20,
                              documentBase64: "")
}
