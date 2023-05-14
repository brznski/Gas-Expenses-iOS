//
//  CarDetailsViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import Foundation

final class CarDetailsViewModel {
    private let carService: CarServiceProtocol

    init(carService: CarServiceProtocol) {
        self.carService = carService
    }

    func deleteCar(carID: Int) {
        Task {
            try await carService.deleteCar(carID: carID)
        }
    }

    func getInsuraceReminderRowConfiguration() -> ReminderRowViewConfiguration {
        return .init(date: .now,
                     title: "insurance",
                     validUntilText: "insurance.valid.until",
                     expiresInText: "insurance.expires.in",
                     isButtonFilled: false) {

        }
    }

    func getTechnicalCheckupReminderRowConfiguration() -> ReminderRowViewConfiguration {
        return .init(date: .now,
                     title: "technical.checkup",
                     validUntilText: "technical.checkup.valid.until",
                     expiresInText: "technical.checkup.expires.in",
                     isButtonFilled: false) {}
    }
}
