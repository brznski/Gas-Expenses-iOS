//
//  JWTService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 19/04/2023.
//

import Foundation

struct JWTService: JWTServiceProtocol {
    func getJWT() async throws -> String {
        return try! await NetworkEngine.download(endpoint: GetJWTEndpoint(accesToken: ""),
                                                 type: JWTResponse.self).jwt
    }
}
