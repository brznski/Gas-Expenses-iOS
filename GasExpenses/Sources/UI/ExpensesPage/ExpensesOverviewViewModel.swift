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
    @Published var expenses: [Expense] = [
        .init(amount: 25.0, title: "Myjnia", date: .distantPast, expenseType: .wash),
        .init(amount: 32.0, title: "Test1", date: .distantPast, expenseType: .fuel)
    ]
    @Published var groupedExpenses: [ExpensesMonth] = {
        let expenses1: [Expense] = [        .init(amount: 25.0, title: "Myjnia", date: .distantPast, expenseType: .wash),
                                            .init(amount: 32.0, title: "Test1", date: .distantPast, expenseType: .fuel),
                                            .init(amount: 200.0, title: "Test date", date: Date(timeIntervalSince1970: 1681328572), expenseType: .fuel)]
        let groupDic = Dictionary(grouping: expenses1) { (pendingCamera) -> DateComponents in

            let date = Calendar.current.dateComponents([.day, .year, .month], from: (pendingCamera.date))

            return date
        }

        var calendar = Calendar(identifier: .gregorian)

        return groupDic.map { (key, value) in

            return ExpensesMonth(date: calendar.date(from: key)!, expenses: value)
        }
    }()
}
