//
//  FuelTypes.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 12/04/2023.
//

import Foundation

enum FuelTypes: String, CaseIterable, Identifiable, Codable {
    var id: String { return self.rawValue }

    case electic = "Electric"
    case lpg = "LPG"
    case on = "ON"
    case pb95 = "PB95"
    case pb98 = "PB98"
}
