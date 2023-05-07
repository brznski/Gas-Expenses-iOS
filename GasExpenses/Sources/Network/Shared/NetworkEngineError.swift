//
//  NetworkEngineError.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 29/04/2023.
//

import Foundation

enum NetworkEngineError: Error {
    case decodeError
    case unauthorized
    case notFound
    case serverUnavailable
    case other
}
