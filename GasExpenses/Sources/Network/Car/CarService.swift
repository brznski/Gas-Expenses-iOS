//
//  CarService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 24/04/2023.
//

import Foundation

class CarService: CarServiceProtocol {
    func getAllCars() async throws -> [Car] {
        return try await NetworkEngine.download(endpoint: GetAllCarsEndpoint(accessToken: AccessTokenManager.shared.getJWTToken()),
                                                type: [Car].self)
    }
}
