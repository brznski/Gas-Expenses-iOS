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
    var headers: [String: Any] { get }
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
            bodyData = try! JSONSerialization.data(withJSONObject: payload,
                                   options: .withoutEscapingSlashes)
        }
        
        var request = URLRequest(url: components.url!)
        request.httpBody = bodyData
        request.httpMethod = method.rawValue
        
        return request
    }
}
