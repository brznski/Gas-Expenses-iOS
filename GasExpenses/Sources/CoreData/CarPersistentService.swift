//
//  CarPersistentService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/05/2023.
//

import Foundation
import CoreData

struct CarPersistentService: CarServiceProtocol {
    let context: NSManagedObjectContext

    func addCar(_ car: Car) async throws {
        var car = PersistentCar(context: context)

        car.name = "CoreData car"
        car.model = "CoreData model"
        car.id = 3
        car.insuranceExpiration = .distantFuture
        car.technicalCheckupExpiration = .distantFuture
        car.fuelType = "PB95"
        car.image = Data()
        car.brand = "CoreData brand"
        car.isFavourite = false

        do {
            try context.save()
            CoreDataStack.shared.saveContext()
        } catch {

        }

        // swiftlint:disable force_try
        let cars = try! context.fetch(PersistentCar.fetchRequest())
        print("2")
    }

    func deleteCar(carID: Int) async throws {

    }

    func editCar(car: Car) async throws {

    }

    func getAllCars() async throws -> [Car] {

        let cars = try! context.fetch(PersistentCar.fetchRequest())
        let carsMapped = cars.map{ Car.map($0) }
        print(carsMapped)
        return carsMapped
    }

    func setFavouriteCar(carID: Int) async throws {

    }
}
