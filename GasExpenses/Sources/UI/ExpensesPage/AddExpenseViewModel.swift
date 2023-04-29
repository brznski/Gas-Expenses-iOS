//
//  AddExpenseViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 29/04/2023.
//

import Foundation

final class AddExpenseViewModel: ObservableObject {
    @Published var cars: [Car] = []

    @Published var title: String = ""
    @Published var amount: String = ""
    @Published var date: Date = .now
    @Published var expenseType: String = ""
    @Published var car: Car?

    private let carDataStore: CarDataSource
    private let expenseService: ExpenseServiceProtocol

    init(
        carDataStore: CarDataSource,
        expenseService: ExpenseServiceProtocol
    ) {
        self.carDataStore = carDataStore
        self.expenseService = expenseService
    }

    func getCars() {
        Task {
            do {
                cars = try await carDataStore.getCars()
            } catch {

            }
        }
    }

    func addExpense() {
        Task {
            do {
                try await expenseService.addExpense(carID: "\(car?.id ?? -1)",
                                                    expense: .init(id: 0,
                                                                   amount: Double(amount) ?? 0,
                                                                   title: title,
                                                                   date: date.JSONDate(),
                                                                   expenseType: ExpenseType(rawValue: expenseType)!))
            }
        }
    }
}
