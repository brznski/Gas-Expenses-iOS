//
//  ExpenseService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 25/04/2023.
//

import Foundation

final class ExpenseService: NetworkEngine, ExpenseServiceProtocol {
    func getAllExpenses(carID: String) async throws -> [Expense] {
        let accessToken = try await AccessTokenManager.shared.getJWTToken()
        let endpoint = GetAllExpensesEndpoint(accessToken: accessToken,
                                                    carID: carID)
        return try await sendRequest(endpoint: endpoint,
                                  type: [Expense].self)
    }

    func addExpense(carID: String, expense: Expense) async throws {
        let accessToken = try await AccessTokenManager.shared.getJWTToken()
        let endpoint = AddExpenseEndpoint(accessToken: accessToken,
                                                carID: carID,
                                                expense: expense)
        _ = try await sendRequest(endpoint: endpoint,
                               type: EmptyModel.self)
    }

    func editExpense(expense: Expense) async throws {
        let accessToken = try await AccessTokenManager.shared.getJWTToken()
        let endpoint = EditExpenseEndpoint(expense: expense, accessToken: accessToken)
        _ = try await sendRequest(endpoint: endpoint,
                               type: EmptyModel.self)
    }

    func deleteExpense(expenseID: Int) async throws {
        let accessToken = try await AccessTokenManager.shared.getJWTToken()
        let endpoint = DeleteExpenseEndpoint(expenseID: expenseID, accessToken: accessToken)
        _ = try await sendRequest(endpoint: endpoint,
                               type: EmptyModel.self)
    }
}
