//
//  ExpensePersistentService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 15/05/2023.
//

import Foundation
import CoreData

struct ExpensePersistentService: ExpenseServiceProtocol, PersistentServiceProtocol {
    var context: NSManagedObjectContext
    
    func getAllExpenses(carID: String) async throws -> [Expense] {
        return try context.fetch(PersistentExpense.fetchRequest()).map { Expense.map($0) }
    }

    func addExpense(carID: String, expense: Expense) async throws {
        guard let car = try context.fetch(PersistentCar.fetchRequest()).first(where: { $0.objectID.hash == Int(carID) }) else { return }
        let persistentExpense = PersistentExpense(context: context)
        persistentExpense.title = expense.title
        persistentExpense.comment = expense.comment
        persistentExpense.expenseType = expense.expenseType.rawValue
        persistentExpense.date = expense.date.dateFromJSON()
        persistentExpense.car = car
        persistentExpense.image = expense.documentBase64?.data(using: .utf8)
        persistentExpense.latitude = expense.latitude ?? -1
        persistentExpense.longitude = expense.longitude ?? -1
        persistentExpense.amount = expense.amount
        try context.save()
    }

    func editExpense(expense: Expense) async throws {
        let refuels = try context.fetch(PersistentRefuel.fetchRequest())
        guard let oldExpense = refuels.first(where: { $0.objectID.hash == expense.id }) else { return }

        let persistentExpense = PersistentExpense(context: context)
        persistentExpense.title = expense.title
        persistentExpense.comment = expense.comment
        persistentExpense.expenseType = expense.expenseType.rawValue
        persistentExpense.date = expense.date.dateFromJSON()
        persistentExpense.car = oldExpense.car
        persistentExpense.image = expense.documentBase64?.data(using: .utf8)
        persistentExpense.latitude = expense.latitude ?? -1
        persistentExpense.longitude = expense.longitude ?? -1
        persistentExpense.amount = expense.amount

        context.delete(oldExpense)
        try context.save()
    }

    func deleteExpense(expenseID: Int) async throws {
        let expenses = try context.fetch(PersistentExpense.fetchRequest())
        guard let expenseToDelete = expenses.first(where: { $0.objectID.hash == expenseID }) else { return }
        context.delete(expenseToDelete)
        try context.save()
    }
}
