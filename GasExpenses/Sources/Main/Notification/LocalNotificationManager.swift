//
//  LocalNotificationManager.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 13/05/2023.
//

import Foundation
import UserNotifications

struct LocalNotificationRequestConfig {
    let identifier: String
    let title: String
    let body: String
    let subtitle: String
    let date: DateComponents
}

final class LocalNotificationManager: NSObject, ObservableObject {
    static let shared = LocalNotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()

    private override init() {
        super.init()
        notificationCenter.delegate = self
    }

    func pendingNotificationRequestExists(identifier: String) async -> Bool {
        let pendingNotifications = await notificationCenter.pendingNotificationRequests()
        if let _ = pendingNotifications.first(where: { $0.identifier == identifier }) {
            return true
        }

        return false
    }

    func sendRequest(configuration: LocalNotificationRequestConfig) {
        notificationCenter.requestAuthorization(options: [.sound, .badge, .alert]) { [notificationCenter] success, error in
            if success && error == nil {
                var content = UNMutableNotificationContent()
                content.title = configuration.title
                content.body = configuration.body
                content.subtitle = configuration.subtitle
                content.sound = .default

                let trigger = UNCalendarNotificationTrigger(dateMatching: configuration.date,
                                                            repeats: false)
                let request = UNNotificationRequest(identifier: configuration.identifier,
                                                    content: content,
                                                    trigger: trigger)

                notificationCenter.add(request)
            }
        }
    }

    func deleteRequest(identifier: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}

extension LocalNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .banner]
    }
}
