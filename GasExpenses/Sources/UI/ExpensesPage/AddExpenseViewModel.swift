//
//  AddExpenseViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 29/04/2023.
//

import Foundation

enum AddExpenseViewContext {
    case add
    case edit
}

final class AddExpenseViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var comment: String = ""
    @Published var amount: String = ""
    @Published var date: Date = .now
    @Published var expenseType: String = "maintenance"
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var documentBase64: Data?

    let context: AddExpenseViewContext

    private let carDataStore: CarDataSource
    private let expenseService: ExpenseServiceProtocol
    
    init(
        carDataStore: CarDataSource,
        expenseService: ExpenseServiceProtocol
    ) {
        self.carDataStore = carDataStore
        self.expenseService = expenseService
        context = .add
    }
    
    init(
        carDataStore: CarDataSource,
        expenseService: ExpenseServiceProtocol,
        expense: Expense
    ) {
        self.carDataStore = carDataStore
        self.expenseService = expenseService
        
        title = expense.title
        comment = expense.title
        amount = "\(expense.amount)"
        date = expense.date.dateFromJSON()!
        expenseType = expense.expenseType.rawValue
        latitude = expense.latitude
        longitude = expense.longitude
        documentBase64 = Data(base64Encoded: expense.documentBase64 ?? "")

        context = .edit
    }
    
    func addExpense() {
        Task {
            do {
                try await expenseService.addExpense(carID: "\(carDataStore.selectedCar?.id)",
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
