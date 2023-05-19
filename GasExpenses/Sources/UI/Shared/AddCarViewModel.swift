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
    private let viewContext: AddExpenseViewContext

    @Published var carName: String = ""
    @Published var carBrand: String = ""
    @Published var carModel: String = ""
    @Published var carFuelType: String = ""
    @Published var insuranceExpiration: Date?
    @Published var technicalCheckupExpiration: Date?
    @Published var imageData: Data?

    init(carService: CarServiceProtocol) {
        self.carService = carService
        self.viewContext = .add
    }

    init(carService: CarServiceProtocol,
         car: Car) {
        self.carService = carService
        self.viewContext = .edit

        self.carID = car.id
        self.carName = car.name
        self.carBrand = car.brand
        self.carModel = car.model
        self.carFuelType = car.fuelType.rawValue

        if let insuranceExpiration = car.insuranceExpiration?.dateFromJSON() {
            self.insuranceExpiration = insuranceExpiration
        }

        if let technicalCheckupExpiration = car.technicalCheckupExpiration?.dateFromJSON() {
            self.insuranceExpiration = technicalCheckupExpiration
        }

        if let imageBase64 = car.imageBase64 {
            self.imageData = Data(base64Encoded: imageBase64)
        }
    }

    func submit(dismiss: @escaping () -> Void) {
        Task {
            switch viewContext {
            case .add:
                await addCar()
            case .edit:
                await editCar()
            }
            dismiss()
        }
    }

    func getSubmitButtonText() -> String {
        switch viewContext {
        case .add:
            return "add"
        case .edit:
            return "edit"
        }
    }

    private func addCar() async {
            do {
                let car = Car(id: carID ?? 0,
                              name: carName,
                              brand: carBrand,
                              model: carModel,
                              refuels: [],
                              fuelType: FuelTypes(rawValue: carFuelType) ?? .pb95,
                              isFavourite: false,
                              imageBase64: imageData?.base64EncodedString(),
                              insuranceExpiration: insuranceExpiration?.JSONDate(),
                              technicalCheckupExpiration: technicalCheckupExpiration?.JSONDate())

                if carID != nil {
                    try await carService.editCar(car: car)
                    return
                }

                try await carService.addCar(car)
            } catch {

            }
    }

    private func editCar() async {
            do {
                let car = Car(id: carID ?? 0,
                              name: carName,
                              brand: carBrand,
                              model: carModel,
                              refuels: [],
                              fuelType: FuelTypes(rawValue: carFuelType) ?? .pb95,
                              isFavourite: false,
                              imageBase64: imageData?.base64EncodedString(),
                              insuranceExpiration: insuranceExpiration?.JSONDate(),
                              technicalCheckupExpiration: technicalCheckupExpiration?.JSONDate())

                if carID != nil {
                    try await carService.editCar(car: car)
                    return
                }

                try await carService.addCar(car)
            } catch {

            }
        }
}
