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
    let title: String
    let date: String
    let expenseType: ExpenseType
    let latitude: Double?
    let longitude: Double?
}

extension Expense {
    static let mock = Expense(id: 3,
                              amount: 350.3,
                              title: "Fuel",
                              date: "",
                              expenseType: .wash,
                              latitude: 54,
                              longitude: 20)
}
