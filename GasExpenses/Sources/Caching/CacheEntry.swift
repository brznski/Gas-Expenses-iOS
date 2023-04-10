//
//  CacheEntry.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

final class CacheEntry<T>: NSDiscardableContent {
    func beginContentAccess() -> Bool { return true }
    func endContentAccess() {}
    func discardContentIfPossible() {}
    func isContentDiscarded() -> Bool { return false }

    let item: T?

    init(item: T) {
        self.item = item
    }
}
