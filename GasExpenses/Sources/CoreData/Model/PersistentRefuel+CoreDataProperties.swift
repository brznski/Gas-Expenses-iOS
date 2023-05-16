//
//  PersistentRefuel+CoreDataProperties.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 15/05/2023.
//
//

import Foundation
import CoreData

extension PersistentRefuel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentRefuel> {
        return NSFetchRequest<PersistentRefuel>(entityName: "PersistentRefuel")
    }

    @NSManaged public var comment: String?
    @NSManaged public var costPerUnit: Double
    @NSManaged public var date: Date?
    @NSManaged public var fuelAmount: Double
    @NSManaged public var image: Data?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var mileage: Double
    @NSManaged public var title: String?
    @NSManaged public var car: PersistentCar?
}

extension PersistentRefuel: Identifiable {

}
