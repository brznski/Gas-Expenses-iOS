//
//  String+Extensions.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 24/04/2023.
//

import Foundation

extension String {
    func dateFromJSON() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:sssZZZZZ"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        return dateFormatter.date(from: self)
    }
}
