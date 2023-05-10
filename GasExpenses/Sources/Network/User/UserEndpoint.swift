//
//  UserEndpoint.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/05/2023.
//

import Foundation

struct CreateUserEndpoint: BackendEndpoint {
    let user: User

    var path: String = "/createUser"
    var method: HTTPMethod = .POST
    var payload: [String: Any] {
        [
            "username": user.username,
            "password": user.password,
            "email": user.email
        ]
    }
    var accessToken: String
}
