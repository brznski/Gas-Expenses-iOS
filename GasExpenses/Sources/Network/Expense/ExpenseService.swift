//
//  ExpenseService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 25/04/2023.
//

import Foundation

final class ExpenseService: NetworkEngine, ExpenseServiceProtocol {
    func getAllExpenses(carID: String) async throws -> [Expense] {
        let endpoint = await GetAllExpensesEndpoint(accessToken: AccessTokenManager.shared.getJWTToken(),
                                                    carID: carID)
        return try await sendRequest(endpoint: endpoint,
                                  type: [Expense].self)
    }

    func addExpense(carID: String, expense: Expense) async throws {
        let endpoint = await AddExpenseEndpoint(accessToken: AccessTokenManager.shared.getJWTToken(),
                                                carID: carID,
                                                expense: expense)
        _ = try await sendRequest(endpoint: endpoint,
                               type: EmptyModel.self)
    }
}
