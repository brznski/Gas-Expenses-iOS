//
//  CarCardInfoRowConfiguration.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 08/04/2023.
//

import Foundation

struct CarCardInfoRowConfiguration: Identifiable {
    var id = UUID()
    let iconName: String
    let text: String
    let helpText: String
    let isPositive: Bool?
}
