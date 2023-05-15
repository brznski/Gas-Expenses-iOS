//
//  Car.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import SwiftUI

struct Car: Identifiable, Codable {
    let id: Int
    let name: String
    let brand: String
    let model: String
    let refuels: [Refuel]
    let fuelType: FuelTypes
    var isFavourite: Bool
    let imageBase64: String?
    let insuranceExpiration: String?
    let technicalCheckupExpiration: String?

    func averageFuelConsumptionSinceLast() -> Double {
        let twoLastRefilsArray = refuels.suffix(2)

        let lastRefill = twoLastRefilsArray.last
        let beforeLastRefill = twoLastRefilsArray.first

        guard twoLastRefilsArray.count == 2,
              let lastRefill,
              let beforeLastRefill else { return 0 }
        let distanceDriven = lastRefill.mileage - beforeLastRefill.mileage

        return (lastRefill.fuelAmount * 100) / distanceDriven
    }

    func distanceDifferenceSinceLast() -> Double {
        let twoLastRefilsArray = refuels.suffix(2)

        let lastRefill = twoLastRefilsArray.last
        let beforeLastRefill = twoLastRefilsArray.first

        guard twoLastRefilsArray.count == 2,
              let lastRefill,
              let beforeLastRefill else { return 0 }

        return lastRefill.mileage - beforeLastRefill.mileage
    }

    func fuelConsumptionDifferenceSinceLast() -> Double {
        let lastFuelConsumption = averageFuelConsumptionSinceLast()

        let beforeLastRefill = refuels[refuels.count - 2]
        let beforeBeforeLastRefill = refuels[refuels.count - 3]

        let distanceDriven = beforeLastRefill.mileage - beforeBeforeLastRefill.mileage

        return lastFuelConsumption - ((beforeLastRefill.fuelAmount * 100) / distanceDriven)
    }

    func gasPerUnitPriceSinceLast() -> Double {
        let twoLastRefuels = refuels.suffix(2)

        let lastRefill = twoLastRefuels.last
        let beforeLastRefill = twoLastRefuels.first

        guard lastRefill != nil, beforeLastRefill != nil else { return 0 }

        return lastRefill!.costPerUnit - beforeLastRefill!.costPerUnit
    }
}

extension Car {
    static var mock: Car {

        var imageBase64: String? = nil

        if let image = UIImage(named: "car_image_test"),
           let imageData = image.jpegData(compressionQuality: 0.5) {
            imageBase64 = imageData.base64EncodedString()
        }
        
        return Car(id: 1,
                   name: "My Subaru",
                   brand: "Subaru",
                   model: "Impreza",
                   refuels: [
                    .init(id: 1,
                          title: "Refuel 1",
                          date: "2023-05-13T00:00:00.000+00:00",
                          comment: "Refuel 1 comment",
                          mileage: 3500,
                          fuelAmount: 20,
                          costPerUnit: 6.78,
                          latitude: 54,
                          longitude: 20,
                          documentBase64: nil),
                    .init(id: 2,
                          title: "Refuel 2",
                          date: "2023-05-17T00:00:00.000+00:00",
                          comment: "Refuel 2 comment",
                          mileage: 4000,
                          fuelAmount: 25,
                          costPerUnit: 6.90,
                          latitude: 54,
                          longitude: 20,
                          documentBase64: nil),
                    .init(id: 3,
                          title: "Refuel 3",
                          date: "2023-05-20T00:00:00.000+00:00",
                          comment: "Refuel 3 comment",
                          mileage: 4200,
                          fuelAmount: 30,
                          costPerUnit: 6.50,
                          latitude: 54,
                          longitude: 20,
                          documentBase64: nil)
                   ],
                   fuelType: .pb95,
                   isFavourite: true,
                   imageBase64: imageBase64,
                   insuranceExpiration: "2024-05-13T00:00:00.000+00:00",
                   technicalCheckupExpiration: "2024-04-13T00:00:00.000+00:00")
    }
}

extension Car: Equatable {
    static func == (lhs: Car, rhs: Car) -> Bool {
        lhs.id == rhs.id
    }
}

extension Car {
    static func map(_ model: PersistentCar) -> Car {
        return Car(id: Int(model.id),
                   name: model.name!,
                   brand: model.brand!,
                   model: model.model!,
                   refuels: [],
                   fuelType: FuelTypes(rawValue: model.fuelType!)!,
                   isFavourite: model.isFavourite,
                   imageBase64: model.image?.base64EncodedString(),
                   insuranceExpiration: model.insuranceExpiration?.JSONDate(),
                   technicalCheckupExpiration: model.technicalCheckupExpiration?.JSONDate())
    }
}
