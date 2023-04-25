//
//  JWTServiceProtocol.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 19/04/2023.
//

import Foundation

protocol JWTServiceProtocol {
    func getJWT() async throws -> String
}
