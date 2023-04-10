//
//  Endpoint.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

protocol Endpoint {
    var request: URLRequest { get }
}
