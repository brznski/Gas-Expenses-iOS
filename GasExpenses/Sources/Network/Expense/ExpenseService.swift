//
//  ExpenseService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 25/04/2023.
//

import Foundation

final class ExpenseService: ExpenseServiceProtocol {
    func getAllExpenses() async throws -> [Expense] {
        return try await NetworkEngine.download(endpoint: GetAllExpensesEndpoint(accessToken: AccessTokenManager.shared.getJWTToken()),
                               type: [Expense].self)
    }
}
