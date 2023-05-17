//
//  CarDetailsViewModel.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import Foundation

final class CarDetailsViewModel: ObservableObject {

    @Published var remindersConfig: [ReminderRowViewConfiguration] = []
    private let carService: CarServiceProtocol
    let model: Car

    init(carService: CarServiceProtocol, car: Car) {
        self.carService = carService
        self.model = car
    }

    func deleteCar(carID: Int) {
        Task {
            try await carService.deleteCar(carID: carID)
        }
    }

    func prepareRemindersConfig() {
        Task {
            let insuranceReminderConfiguration = await getInsuraceReminderRowConfiguration()
            let technicalCheckupReminderConfiguration = await getTechnicalCheckupReminderRowConfiguration()
            DispatchQueue.main.async { [weak self ,insuranceReminderConfiguration, technicalCheckupReminderConfiguration] in
                self?.remindersConfig.append(contentsOf: [insuranceReminderConfiguration, technicalCheckupReminderConfiguration])
            }
        }
    }

    func getInsuraceReminderRowConfiguration() async -> ReminderRowViewConfiguration {
        let shouldIconBeFilled = await LocalNotificationManager.shared.pendingNotificationRequestExists(identifier: "insurance.reminder")

        return .init(date: model.insuranceExpiration?.dateFromJSON() ?? .now,
                     title: "insurance",
                     validUntilText: "insurance.valid.until",
                     expiresInText: "insurance.expires.in",
                     isButtonFilled: shouldIconBeFilled) {
            Task { [weak self] in
                let isNotificationRequested = await LocalNotificationManager.shared.pendingNotificationRequestExists(identifier: "insurance.reminder")
                if !isNotificationRequested,
                   let date = self?.model.technicalCheckupExpiration?.dateFromJSON(),
                   let dateComponents = self?.getDateComponents53WeeksInAdvance(to: date) {
                    LocalNotificationManager.shared.sendRequest(configuration: .init(identifier: "insurance.reminder",
                                                                                     title: "insurance.reminder.title".localized,
                                                                                     body: "insurance.reminder.body".localized,
                                                                                     subtitle: "insurance reminder.subtitle".localized,
                                                                                date: dateComponents))
                } else {
                    LocalNotificationManager.shared.deleteRequest(identifier: "insurance.reminder")
                }
            }
        }
    }

    func getTechnicalCheckupReminderRowConfiguration() async -> ReminderRowViewConfiguration {
        let shouldIconBeFilled = await LocalNotificationManager.shared.pendingNotificationRequestExists(identifier: "technical.checkup.reminder")

        return .init(date: model.technicalCheckupExpiration?.dateFromJSON() ?? .now,
                     title: "technical.checkup",
                     validUntilText: "technical.checkup.valid.until",
                     expiresInText: "technical.checkup.expires.in",
                     isButtonFilled: shouldIconBeFilled) {
            Task { [weak self] in
                let isNotificationRequested = await LocalNotificationManager.shared.pendingNotificationRequestExists(identifier: "technical.checkup.reminder")
                if !isNotificationRequested,
                   let date = self?.model.technicalCheckupExpiration?.dateFromJSON(),
                   let dateComponents = self?.getDateComponents53WeeksInAdvance(to: date) {
                    LocalNotificationManager.shared.sendRequest(configuration: .init(identifier: "technical.checkup.reminder",
                                                                                     title: "technical.checkup.reminder.title".localized,
                                                                                     body: "technical.checkup.reminder.body".localized,
                                                                                     subtitle: "technical.checkup reminder.subtitle".localized,
                                                                                     date: dateComponents))
                } else {
                    LocalNotificationManager.shared.deleteRequest(identifier: "technical.checkup.reminder")
                }
            }
        }
    }

    private func getDateComponents53WeeksInAdvance(to date: Date) -> DateComponents {
        let calendar = Calendar.current
        let initialDate = date
        let newDate = calendar.date(byAdding: .day, value: 358, to: initialDate)
        var dateComponents = DateComponents()
        if let newDate {
            dateComponents.day = calendar.component(.day, from: newDate)
            dateComponents.month = calendar.component(.month, from: newDate)
            dateComponents.year = calendar.component(.year, from: newDate)
        }

        return dateComponents
    }
}
