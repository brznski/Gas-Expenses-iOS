//
//  Refuel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import Foundation

struct Refuel: Identifiable, Codable {
    let id: Int
    let title: String
    let date: String
    let comment: String?
    let mileage: Double
    let fuelAmount: Double
    let costPerUnit: Double
    let latitude: Double?
    let longitude: Double?
    let documentBase64: String?

    func getTotalRefuelValue() -> Double {
        return costPerUnit * fuelAmount
    }
}

extension Refuel {
    static let mock = Refuel(id: 23,
                             title: "BP refuel",
                             date: "2023-31-03",
                             comment: "This is a comment",
                             mileage: 25000,
                             fuelAmount: 30,
                             costPerUnit: 6.54,
                             latitude: 54.3,
                             longitude: 20.3,
                             documentBase64: "")
}

extension Refuel {
    static func map(_ model: PersistentRefuel) -> Refuel {
        return Refuel(id: model.objectID.hash,
                      title: model.title ?? "",
                      date: model.date?.JSONDate() ?? "",
                      comment: model.comment,
                      mileage: model.mileage,
                      fuelAmount: model.fuelAmount,
                      costPerUnit: model.costPerUnit,
                      latitude: model.latitude,
                      longitude: model.longitude,
                      documentBase64: model.image?.base64EncodedString())
    }
}
