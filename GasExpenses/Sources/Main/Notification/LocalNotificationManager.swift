//
//  LocalNotificationManager.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 13/05/2023.
//

import Foundation
import UserNotifications

final class LocalNotificationManager: NSObject, ObservableObject {
    private let notificationCenter = UNUserNotificationCenter.current()

    override init() {
        super.init()
        notificationCenter.delegate = self
    }
}

extension LocalNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .banner]
    }
}
