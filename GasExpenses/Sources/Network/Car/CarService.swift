//
//  CarService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 24/04/2023.
//

import Foundation

struct EmptyModel: Codable {}

class CarService: NetworkEngine, CarServiceProtocol {
    func addCar(_ car: Car) async throws {
        let endpoint = await AddNewCarEndpoint(car: car,
                                               accessToken: AccessTokenManager.shared.getJWTToken())
        _ = try await sendRequest(endpoint: endpoint,
                           type: EmptyModel.self)
    }

    func getAllCars() async throws -> [Car] {
        let endpoint = await GetAllCarsEndpoint(accessToken: AccessTokenManager.shared.getJWTToken())
        return try await sendRequest(endpoint: endpoint,
                                  type: [Car].self)
    }
}
