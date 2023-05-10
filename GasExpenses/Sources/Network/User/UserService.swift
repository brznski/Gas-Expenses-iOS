//
//  UserService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/05/2023.
//

import Foundation

class UserService: NetworkEngine {
    func createUser(user: User) async throws {
        let endpoint = CreateUserEndpoint(user: user, accessToken: "")
        _ = try await sendRequest(endpoint: endpoint, type: EmptyModel.self)
    }
}
