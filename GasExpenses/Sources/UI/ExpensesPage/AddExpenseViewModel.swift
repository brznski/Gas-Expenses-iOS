//
//  AddExpenseViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 29/04/2023.
//

import Foundation

final class AddExpenseViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var comment: String = ""
    @Published var amount: String = ""
    @Published var date: Date = .now
    @Published var expenseType: String = "maintenance"
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var documentBase64: Data?

    private let carID: Int

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
                                                                   comment: comment,
                                                                   title: title,
                                                                   date: date.JSONDate(),
                                                                   expenseType: ExpenseType(rawValue: expenseType) ?? .maintenance,
                                                                   latitude: latitude,
                                                                   longitude: longitude,
                                                                   documentBase64: documentBase64?.base64EncodedString()
                                                                  )
                )
            }
        }
    }
}
