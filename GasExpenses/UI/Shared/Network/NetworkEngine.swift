//
//  NetworkEngine.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 09/04/2023.
//

import Foundation
import Combine

struct NetworkEngine {
    
    static func download<T: Decodable>(endpoint: Endpoint, type: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: endpoint.request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap{(data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      200...300 ~= response.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
