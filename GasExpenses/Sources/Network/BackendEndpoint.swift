//
//  BackendEndpoint.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

protocol BackendEndpoint: Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var payload: [String: Any] { get }
    var accessToken: String { get }
}

extension BackendEndpoint {
    var request: URLRequest {
        var components = URLComponents(url: URL(string: path)!,
                                       resolvingAgainstBaseURL: true)!
        var bodyData: Data = Data()

        switch method {
        case .GET:
            components.queryItems = payload.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        case .POST, .PUT, .DELETE:
            if let serializedData = try? JSONSerialization.data(withJSONObject: payload,
                                                                options: .withoutEscapingSlashes) {
                bodyData = serializedData
            }
        }

        var request = URLRequest(url: components.url!)
        request.httpBody = bodyData
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        return request
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
    }
}
