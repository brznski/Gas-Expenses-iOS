//
//  Location.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import Foundation

struct Location: Codable, Identifiable {
    let id: UUID = UUID()
    let latitude: Double
    let longitude: Double
}
