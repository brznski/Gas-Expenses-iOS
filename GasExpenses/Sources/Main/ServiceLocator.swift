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
    private let viewContext = CoreDataStack.shared.persistentContainer
    private init() {}

    func getCarService() -> CarServiceProtocol {
        return CarPersistentService(context: viewContext.viewContext)
    }

    func getExpenseService() -> ExpenseServiceProtocol {
        usesOnlineCommunication ? ExpenseService() : ExpensePersistentService(context: viewContext.viewContext)
    }

    func getRefuelService() -> RefuelServiceProtocol {
        usesOnlineCommunication ? RefuelService() : RefuelPersistentService(context: viewContext.viewContext)
    }

    func getUserService() -> UserService {
        usesOnlineCommunication ? UserService() : UserService()
    }
}
