//
//  AddCarViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import Foundation

final class AddCarViewModel: ObservableObject {
    private let carService: CarServiceProtocol
    private var carID: Int?

    @Published var carName: String = ""
    @Published var carBrand: String = ""
    @Published var carModel: String = ""
    @Published var carFuelType: String = ""
    @Published var insuranceExpiration: Date?
    @Published var technicalCheckupExpiration: Date?
    @Published var imageData: Data?

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

        if let imageBase64 = car.imageBase64 {
            self.imageData = Data(base64Encoded: imageBase64)
        }
    }

    func addCar() {
        Task {
            do {
                let car = Car(id: carID ?? 0,
                              name: carName,
                              brand: carBrand,
                              model: carModel,
                              refuels: [],
                              fuelType: FuelTypes(rawValue: carFuelType) ?? .pb95,
                              isFavourite: false,
                              imageBase64: imageData?.base64EncodedString(),
                              insuranceExpiration: insuranceExpiration,
                              technicalCheckupExpiration: technicalCheckupExpiration)

                if carID != nil {
                    try await carService.editCar(car: car)
                    return
                }

                try await carService.addCar(car)
            } catch {

            }
        }
    }
}
