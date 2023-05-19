//
//  Car+Mapper.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 19/05/2023.
//

import Foundation

extension Car {
    static func map(_ model: PersistentCar) -> Car {
        return Car(id: model.objectID.hash,
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
