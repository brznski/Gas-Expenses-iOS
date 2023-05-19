//
//  Refuel+Mapper.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 19/05/2023.
//

import Foundation

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
