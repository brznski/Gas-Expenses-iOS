//
//  PersistentCar+CoreDataProperties.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 15/05/2023.
//
//

import Foundation
import CoreData

extension PersistentCar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentCar> {
        return NSFetchRequest<PersistentCar>(entityName: "PersistentCar")
    }

    @NSManaged public var brand: String?
    @NSManaged public var fuelType: String?
    @NSManaged public var image: Data?
    @NSManaged public var insuranceExpiration: Date?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var model: String?
    @NSManaged public var name: String?
    @NSManaged public var technicalCheckupExpiration: Date?
    @NSManaged public var expense: PersistentExpense?
    @NSManaged public var refuel: PersistentRefuel?

}

extension PersistentCar: Identifiable {

}
