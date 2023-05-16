//
//  PersistentRefuel+CoreDataClass.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 15/05/2023.
//
//

import Foundation
import CoreData

@objc(PersistentRefuel)
public class PersistentRefuel: NSManagedObject {

}

extension PersistentRefuel {
    static func map(_ model: Refuel,
                    context: NSManagedObjectContext,
                    car: PersistentCar) -> PersistentRefuel {
        let persistentModel = PersistentRefuel(context: context)

        persistentModel.title = model.title
        persistentModel.comment = model.comment
        persistentModel.car = car
        if let imageBase64 = model.documentBase64 {
            persistentModel.image = Data(base64Encoded: imageBase64)
        }
        if let longitude = model.longitude {
            persistentModel.longitude = longitude
        }

        if let latitude = model.latitude {
            persistentModel.latitude = latitude
        }

        persistentModel.date = model.date.dateFromJSON()
        persistentModel.fuelAmount = model.fuelAmount
        persistentModel.mileage = model.mileage
        persistentModel.costPerUnit = model.costPerUnit

        return persistentModel
    }
}
