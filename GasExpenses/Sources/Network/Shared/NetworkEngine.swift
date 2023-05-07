//
//  NetworkEngine.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 09/04/2023.
//

import Foundation
import Combine

class NetworkEngine {
    func sendRequest<T: Decodable>(endpoint: Endpoint, type: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: endpoint.request)

        if let urlResponse = response as? HTTPURLResponse,
           400...599 ~= urlResponse.statusCode {
            switch urlResponse.statusCode {
            case 300...400:
                throw NetworkEngineError.decodeError
            case 401, 403:
                throw NetworkEngineError.unauthorized
            case 500...503:
                throw NetworkEngineError.serverUnavailable
            default:
                throw NetworkEngineError.other
            }
        }

        do {
            guard let decodedObject = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkEngineError.decodeError }
            return decodedObject
        } catch let error {
            throw error
        }
    }
}
