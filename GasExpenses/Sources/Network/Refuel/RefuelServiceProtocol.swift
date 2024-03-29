//
//  RefuelServiceProtocol.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 27/04/2023.
//

import Foundation

protocol RefuelServiceProtocol {
    func getRefuels(carID: Int) async throws -> [Refuel]
    func addRefuel(_ refuel: Refuel, carID: Int) async throws
    func editRefuel(_ refuel: Refuel) async throws
    func deleteRefuel(refuelID: Int) async throws
}
