//
//  NetworkEngine.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 09/04/2023.
//

import Foundation
import Combine

struct NetworkEngine {

    static func download<T: Decodable>(endpoint: Endpoint, type: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: endpoint.request)

        if let urlResponse = response as? HTTPURLResponse,
           400...599 ~= urlResponse.statusCode {
            throw URLError(.secureConnectionFailed)
        }

        do {

            // swiftlint:disable force_try
            let decodedObject = try! JSONDecoder().decode(T.self, from: data)

            return decodedObject
        } catch(let error) {
            throw error
        }
    }
}
