//
//  ServiceLocator.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 14/05/2023.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()
    private let usesOnlineCommunication = Storage.usesOnlineServices
    private init() {}

    func getCarService() -> CarServiceProtocol {
        usesOnlineCommunication ? CarService() : CarService()
    }

    func getExpenseService() -> ExpenseServiceProtocol {
        usesOnlineCommunication ? ExpenseService() : ExpenseService()
    }

    func getRefuelService() -> RefuelServiceProtocol {
        usesOnlineCommunication ? RefuelService() : RefuelService()
    }

    func getUserService() -> UserService {
        usesOnlineCommunication ? UserService() : UserService()
    }
}
