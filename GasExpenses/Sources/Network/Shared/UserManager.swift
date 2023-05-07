//
//  UserManager.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 07/05/2023.
//

import Foundation
import SwiftUI

struct User: Codable {
    var username: String
    var password: String
    var email: String
}

final class UserManager: ObservableObject {
    static let shared = UserManager()

    @Published var user: User?
    @Published var isUserLoggedIn: Bool = false

    private init() {}

    func forgetUser() {
        UserDefaults.standard.removeObject(forKey: "user.credentials")
    }
}
