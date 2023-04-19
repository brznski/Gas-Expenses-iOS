//
//  GetJWTEndpoint.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 19/04/2023.
//

import Foundation

struct GetJWTEndpoint: BackendEndpoint {
    var accessToken: String
    var path: String = "/authenticate"
    var method: HTTPMethod = .POST
    var payload: [String : Any] = [:]

    init(accesToken: String) {
        self.accessToken = accesToken
    }
}
