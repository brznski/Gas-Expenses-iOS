//
//  RefuelService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 27/04/2023.
//

import Foundation

class RefuelService: NetworkEngine, RefuelServiceProtocol {
    func addRefuel(_ refuel: Refuel, carID: Int) async throws {
        let endpoint = await AddRefuelEndpoint(accessToken: AccessTokenManager.shared.getJWTToken(),
                                               refuel: refuel,
                                               carID: carID)
        _ = try await sendRequest(endpoint: endpoint, type: EmptyModel.self)
    }
}
