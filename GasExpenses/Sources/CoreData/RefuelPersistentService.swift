//
//  RefuelPersistentService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 15/05/2023.
//

import Foundation
import CoreData

struct RefuelPersistentService: RefuelServiceProtocol, PersistentServiceProtocol {
    var context: NSManagedObjectContext

    func getRefuels(carID: Int) async throws -> [Refuel] {
        return try context.fetch(PersistentRefuel.fetchRequest()).map { Refuel.map($0) }
    }

    func addRefuel(_ refuel: Refuel, carID: Int) async throws {
        guard let car = try context.fetch(PersistentCar.fetchRequest()).first(where: { $0.objectID.hash == Int(carID) }) else { return }

        let persistentModel = PersistentRefuel(context: context)

        persistentModel.title = refuel.title
        persistentModel.comment = refuel.comment
        persistentModel.car = car
        if let imageBase64 = refuel.documentBase64 {
            persistentModel.image = Data(base64Encoded: imageBase64)
        }
        if let longitude = refuel.longitude {
            persistentModel.longitude = longitude
        }

        if let latitude = refuel.latitude {
            persistentModel.latitude = latitude
        }

        persistentModel.date = refuel.date.dateFromJSON()
        persistentModel.fuelAmount = refuel.fuelAmount
        persistentModel.mileage = refuel.mileage
        persistentModel.costPerUnit = refuel.costPerUnit

        CoreDataStack.shared.saveContext()
    }

    func editRefuel(_ refuel: Refuel) async throws {
        let persistentModel = PersistentRefuel(context: context)

        persistentModel.title = refuel.title
        persistentModel.comment = refuel.comment
        if let imageBase64 = refuel.documentBase64 {
            persistentModel.image = Data(base64Encoded: imageBase64)
        }
        if let longitude = refuel.longitude {
            persistentModel.longitude = longitude
        }

        if let latitude = refuel.latitude {
            persistentModel.latitude = latitude
        }

        persistentModel.date = refuel.date.dateFromJSON()
        persistentModel.fuelAmount = refuel.fuelAmount
        persistentModel.mileage = refuel.mileage
        persistentModel.costPerUnit = refuel.costPerUnit

        let refuels = try context.fetch(PersistentRefuel.fetchRequest())

        guard let oldRefuel = refuels.first(where: { $0.objectID.hash == refuel.id }) else { return }

        persistentModel.car = oldRefuel.car
        context.delete(oldRefuel)
        try context.save()
    }

    func deleteRefuel(refuelID: Int) async throws {
        let refuels = try context.fetch(PersistentRefuel.fetchRequest())
        guard let refuelToDelete = refuels.first(where: { $0.objectID.hash == refuelID }) else { return }
        context.delete(refuelToDelete)
        try context.save()
    }
}
