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
    let location: Location
}
