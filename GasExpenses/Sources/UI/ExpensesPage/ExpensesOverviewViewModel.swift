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
    @Published var filters: ExpenseFilter = .init() {
        didSet {
            filteredRefuels = refuels
            filteredExpenses = expenses
            filterRefuels()
            filterExpenses()
        }
    }
    @Published var expenses: [Expense] = []
    @Published var groupedExpenses: [ExpensesMonth] = []
    @Published var refuels: [Refuel] = []
    private var filteredRefuels: [Refuel] = []
    private var filteredExpenses: [Expense] = []
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
        let service = ServiceLocator.shared.getExpenseService()
        let response = try await service.getAllExpenses(carID: "\(carID)")
        DispatchQueue.main.async { [weak self] in
            self?.expenses = response
            self?.filteredExpenses = response
            self?.filterExpenses()
        }
    }

    func getRefuels() async throws {
        let response = try await refuelService.getRefuels(carID: carID)
        DispatchQueue.main.async { [weak self] in
            self?.refuels = response
            self?.filteredRefuels = response
            self?.filterRefuels()
        }
    }

    func groupExpenses() {
        let groupDic = Dictionary(grouping: filteredExpenses) { (pendingCamera) -> DateComponents in

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
        let groupDic = Dictionary(grouping: filteredRefuels) { (pendingCamera) -> DateComponents in

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

    func filterRefuels() {
        if !filters.title.isEmpty {
            filteredRefuels = refuels.filter { $0.title.contains(filters.title) }
        }

        if !filters.amountFrom.isEmpty,
           let amountFrom = Double(filters.amountFrom) {
            filteredRefuels = refuels.filter { ($0.fuelAmount * $0.costPerUnit) > amountFrom }
        }

        if !filters.amountTo.isEmpty,
           let amountTo = Double(filters.amountTo) {
            filteredRefuels = refuels.filter { ($0.fuelAmount * $0.costPerUnit) < amountTo }
        }

        if let dateFrom = filters.dateFrom {
            filteredRefuels = refuels.filter { $0.date.dateFromJSON()! > dateFrom }
        }

        if let dateTo = filters.dateFrom {
            filteredRefuels = refuels.filter { $0.date.dateFromJSON()! < dateTo }
        }

        groupRefuels()
    }

    func filterExpenses() {
        if !filters.title.isEmpty {
            filteredExpenses = expenses.filter { $0.title.contains(filters.title) }
        }

        if !filters.amountFrom.isEmpty,
           let amountFrom = Double(filters.amountFrom) {
            filteredExpenses = expenses.filter { $0.amount > amountFrom }
        }

        if !filters.amountTo.isEmpty,
           let amountTo = Double(filters.amountTo) {
            filteredExpenses = expenses.filter { $0.amount < amountTo }
        }

        if let dateFrom = filters.dateFrom {
            filteredExpenses = expenses.filter { $0.date.dateFromJSON()! > dateFrom }
        }

        if let dateTo = filters.dateFrom {
            filteredExpenses = expenses.filter { $0.date.dateFromJSON()! < dateTo }
        }

        if !filters.expenseType.isEmpty {
            filteredExpenses = expenses.filter { $0.expenseType.rawValue == filters.expenseType }
        }

        groupExpenses()
    }
}
