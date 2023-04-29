//
//  JWTService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 19/04/2023.
//

import Foundation

class JWTService: NetworkEngine, JWTServiceProtocol {
    func getJWT() async throws -> String {
        let endpoint = GetJWTEndpoint(accesToken: "")
        return try await sendRequest(endpoint: endpoint,
                                  type: JWTResponse.self).jwt
    }
}
