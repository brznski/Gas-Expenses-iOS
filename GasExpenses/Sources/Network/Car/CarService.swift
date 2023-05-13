//
//  CarService.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 24/04/2023.
//

import Foundation

struct EmptyModel: Codable {}

class CarService: NetworkEngine, CarServiceProtocol {
    func getAllCars() async throws -> [Car] {
        let endpoint = await GetAllCarsEndpoint(accessToken: try AccessTokenManager.shared.getJWTToken())
        return try await sendRequest(endpoint: endpoint,
                                  type: [Car].self)
    }

    func addCar(_ car: Car) async throws {
        let endpoint = await AddNewCarEndpoint(car: car,
                                               accessToken: try AccessTokenManager.shared.getJWTToken())
        _ = try await sendRequest(endpoint: endpoint,
                           type: EmptyModel.self)
    }

    func editCar(car: Car) async throws {
        let accessToken = try await AccessTokenManager.shared.getJWTToken()
        let endpoint = EditCarEndpoint(car: car, accessToken: accessToken)
        _ = try await sendRequest(endpoint: endpoint,
                                  type: EmptyModel.self)
    }

    func deleteCar(carID: Int) async throws {
        let endpoint = await DeleteCarEndpoint(carID: carID, accessToken: try AccessTokenManager.shared.getJWTToken())
        _ = try await sendRequest(endpoint: endpoint,
                                  type: EmptyModel.self)
    }

    func setFavouriteCar(carID: Int) async throws {
        let endpoint = await SetFavouriteCarEndpoint(carID: carID, accessToken: try AccessTokenManager.shared.getJWTToken())
        _ = try await sendRequest(endpoint: endpoint,
                                     type: EmptyModel.self)
    }
}
