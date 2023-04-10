//
//  Date+Extensions.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

extension Double {
    func odometerString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        numberFormatter.groupingSize = 3
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.numberStyle = .decimal
        numberFormatter.usesGroupingSeparator = true

        return numberFormatter.string(from: self as NSNumber)
    }

    func currencyString() -> String? {
        let numberFormatter = NumberFormatter()
//        numberFormatter.maximumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "zł"
        numberFormatter.usesGroupingSeparator = true

        return numberFormatter.string(from: self as NSNumber)
    }
}
