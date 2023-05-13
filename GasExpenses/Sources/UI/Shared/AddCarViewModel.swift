//
//  AddCarViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import Foundation

final class AddCarViewModel: ObservableObject {
    private let carService: CarServiceProtocol
    private var carID: Int? = nil

    @Published var carName: String = ""
    @Published var carBrand: String = ""
    @Published var carModel: String = ""
    @Published var carFuelType: String = ""
    @Published var insuranceExpiration: Date = .now
    @Published var technicalCheckupExpiration: Date = .now
    @Published var imageData: Data? = nil

    init(carService: CarServiceProtocol) {
        self.carService = carService
    }

    init(carService: CarServiceProtocol,
         car: Car) {
        self.carService = carService

        self.carID = car.id
        self.carName = car.name
        self.carBrand = car.brand
        self.carModel = car.model
        self.carFuelType = car.fuelType.rawValue

        if let insuranceExpiration = car.insuranceExpiration {
            self.insuranceExpiration = insuranceExpiration
        }

        if let technicalCheckupExpiration = car.technicalCheckupExpiration {
            self.insuranceExpiration = technicalCheckupExpiration
        }

        self.imageData = Data(base64Encoded: car.imageBase64)
    }

    func addCar() {

    }
}
