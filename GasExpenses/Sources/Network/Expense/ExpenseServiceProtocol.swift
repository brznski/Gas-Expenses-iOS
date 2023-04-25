//
//  ExpenseServiceProtocol.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 25/04/2023.
//

import Foundation

protocol ExpenseServiceProtocol {
    func getAllExpenses() async throws -> [Expense]
}
