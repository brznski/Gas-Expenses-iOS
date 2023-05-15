//
//  PersistentCar+CoreDataProperties.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/05/2023.
//
//

import Foundation
import CoreData

extension PersistentCar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentCar> {
        return NSFetchRequest<PersistentCar>(entityName: "PersistentCar")
    }

    @NSManaged public var id: Int16
    @NSManaged public var brand: String?
    @NSManaged public var fuelType: String?
    @NSManaged public var image: Data?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var model: String?
    @NSManaged public var name: String?
    @NSManaged public var insuranceExpiration: Date?
    @NSManaged public var technicalCheckupExpiration: Date?

}

extension PersistentCar: Identifiable {

}
