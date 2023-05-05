//
//  CarServiceProtocol.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 24/04/2023.
//

import Foundation

protocol CarServiceProtocol {
    func addCar(_ car: Car) async throws
    func deleteCar(carID: Int) async throws
    func getAllCars() async throws -> [Car]
    func setFavouriteCar(carID: Int) async throws
}
