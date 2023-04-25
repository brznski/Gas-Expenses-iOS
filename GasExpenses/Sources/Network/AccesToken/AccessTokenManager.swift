//
//  AccessTokenManager.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 19/04/2023.
//

import Foundation

actor AccessTokenManager {

    static let shared = AccessTokenManager(jwtService: JWTService())

    private init(jwtService: JWTServiceProtocol) {
        self.jwtService = jwtService
    }

    private let jwtService: JWTServiceProtocol
    private var token: String = ""
    private var expirationDate = Date.now

    private var isValid: Bool {
        if token.isEmpty {
            return false
        }

        if expirationDate < .now {
            return false
        }

        return true
    }

    func getJWTToken() async -> String {
        if isValid {
            return token
        }

        do {
            token = try await jwtService.getJWT()
        } catch {

        }

        if let twoHoursInAdvance = Calendar.current.date(byAdding: .hour,
                                                         value: 2,
                                                         to: .now) {
            expirationDate = twoHoursInAdvance
        }

        return token
    }
}
