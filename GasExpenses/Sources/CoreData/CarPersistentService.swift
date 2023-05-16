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
        let persistentCar = PersistentCar(context: context)

        persistentCar.name = car.name
        persistentCar.model = car.model
        persistentCar.insuranceExpiration = car.insuranceExpiration?.dateFromJSON()
        persistentCar.technicalCheckupExpiration = car.insuranceExpiration?.dateFromJSON()
        persistentCar.fuelType = car.fuelType.rawValue
        persistentCar.image = Data(base64Encoded: car.imageBase64 ?? "")
        persistentCar.brand = car.brand
        persistentCar.isFavourite = car.isFavourite

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
    }
}
