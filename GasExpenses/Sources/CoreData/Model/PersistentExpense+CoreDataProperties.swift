//
//  PersistentExpense+CoreDataProperties.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 15/05/2023.
//
//

import Foundation
import CoreData

extension PersistentExpense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentExpense> {
        return NSFetchRequest<PersistentExpense>(entityName: "PersistentExpense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var comment: String?
    @NSManaged public var date: Date?
    @NSManaged public var expenseType: String?
    @NSManaged public var image: Data?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var title: String?
    @NSManaged public var car: PersistentCar?

}

extension PersistentExpense: Identifiable {

}
