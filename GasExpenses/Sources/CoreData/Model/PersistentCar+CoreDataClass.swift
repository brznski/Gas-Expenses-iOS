//
//  PersistentCar+CoreDataClass.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 15/05/2023.
//
//

import Foundation
import CoreData

@objc(PersistentCar)
public class PersistentCar: NSManagedObject {

}

extension PersistentCar {
    static func map(_ model: Car, context: NSManagedObjectContext) -> PersistentCar {
        let persistentCar = PersistentCar(context: context)
        persistentCar.name = model.name
        persistentCar.model = model.model
//        persistentCar.refuel = PersistentRefuel.map
        persistentCar.insuranceExpiration = model.insuranceExpiration?.dateFromJSON()
        persistentCar.technicalCheckupExpiration = model.insuranceExpiration?.dateFromJSON()
        persistentCar.fuelType = model.fuelType.rawValue
        persistentCar.image = Data(base64Encoded: model.imageBase64 ?? "")
        persistentCar.brand = model.brand
        persistentCar.isFavourite = model.isFavourite

        return persistentCar
    }
}
