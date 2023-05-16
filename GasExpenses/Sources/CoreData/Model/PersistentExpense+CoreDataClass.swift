//
//  PersistentExpense+CoreDataClass.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 15/05/2023.
//
//

import Foundation
import CoreData

@objc(PersistentExpense)
public class PersistentExpense: NSManagedObject {

}

extension PersistentExpense {
    static func map(_ model: Expense,
                    context: NSManagedObjectContext,
                    car: PersistentCar) -> PersistentExpense {
        let persistentExpense = PersistentExpense(context: context)
        persistentExpense.amount = model.amount
        persistentExpense.title = model.title
        persistentExpense.comment = model.comment
        persistentExpense.date = model.date.dateFromJSON()
        persistentExpense.expenseType = model.expenseType.rawValue

        if let imageBase64 = model.documentBase64,
           let imageData = Data(base64Encoded: imageBase64) {
            persistentExpense.image = imageData
        }

        if let latitude = model.latitude {
            persistentExpense.latitude = latitude
        }

        if let longitude = model.longitude {
            persistentExpense.longitude = longitude
        }

        return persistentExpense
    }
}
