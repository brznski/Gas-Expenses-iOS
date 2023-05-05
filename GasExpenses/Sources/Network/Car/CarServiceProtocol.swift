//
//  CarServiceProtocol.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 24/04/2023.
//

import Foundation

protocol CarServiceProtocol {
    func getAllCars() async throws -> [Car]
    func addCar(_ car: Car) async throws
    func setFavouriteCar(carID: Int) async throws
}
