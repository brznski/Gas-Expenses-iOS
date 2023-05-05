//
//  AddExpenseViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 29/04/2023.
//

import Foundation

final class AddExpenseViewModel: ObservableObject {
    @Published var carID: Int
    @Published var title: String = ""
    @Published var amount: String = ""
    @Published var date: Date = .now
    @Published var expenseType: String = ""

    private let carDataStore: CarDataSource
    private let expenseService: ExpenseServiceProtocol

    init(
        carDataStore: CarDataSource,
        expenseService: ExpenseServiceProtocol,
        carID: Int
    ) {
        self.carDataStore = carDataStore
        self.expenseService = expenseService
        self.carID = carID
    }

    func addExpense() {
        Task {
            do {
                try await expenseService.addExpense(carID: "\(carID)",
                                                    expense: .init(id: 0,
                                                                   amount: Double(amount) ?? 0,
                                                                   title: title,
                                                                   date: date.JSONDate(),
                                                                   expenseType: ExpenseType(rawValue: expenseType)!,
                                                                   latitude: 0,
                                                                   longitude: 0))
            }
        }
    }
}
