//
//  RefuelServiceProtocol.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 27/04/2023.
//

import Foundation

protocol RefuelServiceProtocol {
    func addRefuel(_ refuel: Refuel, carID: Int) async throws
}
