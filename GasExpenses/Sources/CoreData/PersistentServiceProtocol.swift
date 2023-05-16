//
//  PersistentServiceProtocol.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 15/05/2023.
//

import Foundation
import CoreData

protocol PersistentServiceProtocol {
    var context: NSManagedObjectContext { get }
}
