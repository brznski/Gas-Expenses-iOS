//
//  CarPersistentService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/05/2023.
//

import Foundation
import CoreData

struct CarPersistentService: CarServiceProtocol, PersistentServiceProtocol {
    let context: NSManagedObjectContext

    func addCar(_ car: Car) async throws {
        let persistentCar = PersistentCar.map(car, context: context)

        CoreDataStack.shared.saveContext()
    }

    func deleteCar(carID: Int) async throws {
        var cars = try context.fetch(PersistentCar.fetchRequest())
        if let carToDelete = cars.first(where: { $0.objectID.hash == carID }) {
            context.delete(carToDelete)
        }
        try context.save()
        cars = try context.fetch(PersistentCar.fetchRequest())
    }

    func editCar(car: Car) async throws {
        var cars = try context.fetch(PersistentCar.fetchRequest())

        if let oldCar = cars.first(where: { $0.objectID.hash == car.id }) {
            context.delete(oldCar)
        }

        let editedCar = PersistentCar.map(car, context: context)

        try context.save()
        cars = try context.fetch(PersistentCar.fetchRequest())
    }

    func getAllCars() async throws -> [Car] {

        let cars = try context.fetch(PersistentCar.fetchRequest())
        let carsMapped = cars.map { Car.map($0) }
        return carsMapped
    }

    func setFavouriteCar(carID: Int) async throws {
        var cars = try context.fetch(PersistentCar.fetchRequest())
        cars.forEach {
            if $0.objectID.hash == carID {
                $0.isFavourite = true
            } else {
                $0.isFavourite = false
            }
        }

        try context.save()
    }
}
