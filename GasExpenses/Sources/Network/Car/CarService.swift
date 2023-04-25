//
//  CarService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 24/04/2023.
//

import Foundation

class CarService: NetworkEngine, CarServiceProtocol {
    func getAllCars() async throws -> [Car] {
        let endpoint = await GetAllCarsEndpoint(accessToken: AccessTokenManager.shared.getJWTToken())
        return try await download(endpoint: endpoint,
                                  type: [Car].self)
    }
}
