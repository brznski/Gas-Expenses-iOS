//
//  MockCar.swift
//  GasExpensesTests
//
//  Created by Michał Brzeziński on 24/04/2023.
//

import Foundation

extension Car {
    static func getMockCar() -> Car {
        Car(id: 1, name: "My Subaru",
            brand: "Subaru",
            model: "Impreza",
            refuels: [
                .init(id: 1,
                      title: "Refuel1",
                      date: "2023-04-18T00:00:00.000+00:00",
                      comment: "",
                      mileage: 164900.0,
                      fuelAmount: 20.0,
                      costPerUnit: 3.60,
                      latitude: 0,
                      longitude: 0,
                     documentBase64: ""),
                .init(id: 1,
                      title: "Refuel1",
                      date: "2023-04-18T00:00:00.000+00:00",
                      comment: "",
                      mileage: 164900.0,
                      fuelAmount: 20.0,
                      costPerUnit: 3.60,
                      latitude: 0,
                      longitude: 0,
                     documentBase64: ""),
                .init(id: 1,
                      title: "Refuel1",
                      date: "2023-04-18T00:00:00.000+00:00",
                      comment: "",
                      mileage: 164900.0,
                      fuelAmount: 20.0,
                      costPerUnit: 3.60,
                      latitude: 0,
                      longitude: 0,
                     documentBase64: "")
            ],
            fuelType: .pb95,
            isFavourite: true,
            imageBase64: "",
            insuranceExpiration: "2023-04-18T00:00:00.000+00:00",
            technicalCheckupExpiration: "2023-04-18T00:00:00.000+00:00")
    }
}
