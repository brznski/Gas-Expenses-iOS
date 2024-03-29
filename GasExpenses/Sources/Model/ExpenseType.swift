//
//  ExpenseType.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 05/05/2023.
//

import Foundation

enum ExpenseType: String, Identifiable, CaseIterable, Codable {
    var id: String { return self.rawValue }
    case wash
    case fuel
    case maintenance
    case insurance
    case parts
    case undefinied = ""
}
