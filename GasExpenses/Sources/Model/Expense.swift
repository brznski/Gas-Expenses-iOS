//
//  Expense.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import Foundation

struct Expense: Identifiable, Codable {
    let id: Int
    let amount: Double
    let comment: String?
    let title: String
    let date: String
    let expenseType: ExpenseType
    let latitude: Double?
    let longitude: Double?
    let documentBase64: String?
}

extension Expense {
    static let mock = Expense(id: 3,
                              amount: 350.3,
                              comment: "This is a payment for clutch and gearbox",
                              title: "Fuel",
                              date: "2023-05-16 02:00:00.000000",
                              expenseType: .wash,
                              latitude: 54,
                              longitude: 20,
                              documentBase64: "")
}

extension Expense {
    static func map(_ model: PersistentExpense) -> Expense {
        return Expense(id: model.objectID.hash,
                       amount: model.amount,
                       comment: model.comment,
                       title: model.title ?? "",
                       date: model.date?.JSONDate() ?? "",
                       expenseType: ExpenseType(rawValue: model.expenseType ?? "") ?? .undefinied,
                       latitude: model.latitude,
                       longitude: model.latitude,
                       documentBase64: model.image?.base64EncodedString())
    }
}
