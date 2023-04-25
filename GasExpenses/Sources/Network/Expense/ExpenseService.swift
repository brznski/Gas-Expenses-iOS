//
//  ExpenseService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 25/04/2023.
//

import Foundation

final class ExpenseService: NetworkEngine, ExpenseServiceProtocol {
    func getAllExpenses() async throws -> [Expense] {
        let endpoint = await GetAllExpensesEndpoint(accessToken: AccessTokenManager.shared.getJWTToken())
        return try await download(endpoint: endpoint,
                                  type: [Expense].self)
    }
}
