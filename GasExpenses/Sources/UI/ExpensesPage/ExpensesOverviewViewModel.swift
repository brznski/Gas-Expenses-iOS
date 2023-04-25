//
//  ExpensesOverviewViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import Foundation

struct ExpensesMonth: Identifiable {
    let id = UUID()
    let date: Date
    let expenses: [Expense]
}

final class ExpensesOverviewViewModel: ObservableObject {
    @Published var filters: ExpenseFilter = .init()
    @Published var expenses: [Expense] = []
    @Published var groupedExpenses: [ExpensesMonth] = []

    func getExpenses() async throws {
        let service = ExpenseService()
        let response = try await service.getAllExpenses()
        DispatchQueue.main.async { [weak self] in
            self?.expenses = response
        }
    }

    func groupExpenses() {
        let groupDic = Dictionary(grouping: expenses) { (pendingCamera) -> DateComponents in

            let date = Calendar.current.dateComponents([.day, .year, .month], from: (pendingCamera.date.dateFromJSON()!))

            return date
        }

        var calendar = Calendar(identifier: .gregorian)

        groupedExpenses = groupDic.map { (key, value) in

            return ExpensesMonth(date: calendar.date(from: key)!, expenses: value)
        }
    }

    func getLastMonthExpenses() -> Double {
        guard let lastMonth = groupedExpenses.sorted(by: {$0.date < $1.date}).last else { return 0 }

        return lastMonth.expenses.reduce(0) { _, expense in
            return expense.amount
        }
    }
}
