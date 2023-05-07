//
//  JWTServiceProtocol.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 19/04/2023.
//

import Foundation

protocol JWTServiceProtocol {
    func getJWT(username: String, password: String) async throws -> String
}
