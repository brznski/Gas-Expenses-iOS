//
//  RefuelService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 27/04/2023.
//

import Foundation

class RefuelService: NetworkEngine, RefuelServiceProtocol {
    func getRefuels(carID: Int) async throws -> [Refuel] {
        let accessToken = try await AccessTokenManager.shared.getJWTToken()
        let endpoint = GetAllRefuelsEndpoint(carID: carID, accessToken: accessToken)
        return try await sendRequest(endpoint: endpoint, type: [Refuel].self)
    }

    func addRefuel(_ refuel: Refuel, carID: Int) async throws {
        let accessToken = try await AccessTokenManager.shared.getJWTToken()
        let endpoint = await AddRefuelEndpoint(accessToken: accessToken,
                                               refuel: refuel,
                                               carID: carID)
        _ = try await sendRequest(endpoint: endpoint, type: EmptyModel.self)
    }
}
