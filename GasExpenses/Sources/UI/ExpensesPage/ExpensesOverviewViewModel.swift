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
    var expenses: [Expense]

    mutating func sortExpenses() {
        expenses = expenses.sorted { $0.date.dateFromJSON()! < $1.date.dateFromJSON()! }
    }
}

struct RefuelsMonth: Identifiable {
    let id = UUID()
    let date: Date
    var refuels: [Refuel]

    mutating func sortExpenses() {
        refuels = refuels.sorted { $0.date.dateFromJSON()! < $1.date.dateFromJSON()! }
    }
}

final class ExpensesOverviewViewModel: ObservableObject {
    @Published var filters: ExpenseFilter = .init()
    @Published var expenses: [Expense] = []
    @Published var groupedExpenses: [ExpensesMonth] = []
    @Published var refuels: [Refuel] = []
    @Published var groupedRefuels: [RefuelsMonth] = []
    @Published var lastMonthExpenses: Double = 0.0

    let carID: Int
    private let carDataSource: CarDataSource
    private let refuelService: RefuelServiceProtocol

    init(carID: Int,
         carDataSource: CarDataSource,
         refuelService: RefuelServiceProtocol) {
        self.carID = carID
        self.carDataSource = carDataSource
        self.refuelService = refuelService
    }

    func getExpenses() async throws {
        let service = ExpenseService()
        let response = try await service.getAllExpenses(carID: "\(carID)")
        DispatchQueue.main.async { [weak self] in
            self?.expenses = response
        }
    }

    func getRefuels() async throws {
        let response = try await refuelService.getRefuels(carID: carID)
        refuels = response
    }

    func groupExpenses() {
        let groupDic = Dictionary(grouping: expenses) { (pendingCamera) -> DateComponents in

            let date = Calendar.current.dateComponents([.year, .month], from: (pendingCamera.date.dateFromJSON()!))

            return date
        }

        let calendar = Calendar(identifier: .gregorian)

        groupedExpenses = groupDic.map { (key, value) in
            return ExpensesMonth(date: calendar.date(from: key)!, expenses: value)
        }

        var tempGroupExpenses = [ExpensesMonth]()

        groupedExpenses.forEach {
            let sortedExpenses = $0.expenses.sorted { $0.date.dateFromJSON()! > $1.date.dateFromJSON()! }
            tempGroupExpenses.append(ExpensesMonth(date: $0.date, expenses: sortedExpenses)) }

        groupedExpenses = tempGroupExpenses

        groupedExpenses.sort { $0.date.JSONDate() > $1.date.JSONDate() }
    }

    func groupRefuels() {
        let groupDic = Dictionary(grouping: refuels) { (pendingCamera) -> DateComponents in

            let date = Calendar.current.dateComponents([.year, .month], from: (pendingCamera.date.dateFromJSON()!))

            return date
        }

        let calendar = Calendar(identifier: .gregorian)

        groupedRefuels = groupDic.map { (key, value) in
            return RefuelsMonth(date: calendar.date(from: key)!, refuels: value)
        }

        var tempGroupExpenses = [RefuelsMonth]()

        groupedRefuels.forEach {
            let sortedExpenses = $0.refuels.sorted { $0.date.dateFromJSON()! > $1.date.dateFromJSON()! }
            tempGroupExpenses.append(RefuelsMonth(date: $0.date, refuels: sortedExpenses)) }

        groupedRefuels = tempGroupExpenses

        groupedRefuels.sort { $0.date.JSONDate() > $1.date.JSONDate() }
    }

    func getLastMonthExpenses() {
        guard let lastMonth = groupedExpenses.sorted(by: {$0.date < $1.date}).last else { return }

        lastMonthExpenses = lastMonth.expenses.reduce(0) { partial, expense in
            return expense.amount + partial
        }
    }

    func getLastMonthRefuels() {
        guard let lastMonth = groupedRefuels.sorted(by: {$0.date < $1.date}).last else { return }

        var sum = 0.0

        lastMonth.refuels.forEach { sum += $0.costPerUnit * $0.fuelAmount }

        lastMonthExpenses = sum
    }
}
