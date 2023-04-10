//
//  CacheKey.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

final class CacheKey: NSObject {
    let cacheKey: String
    
    init(_ cacheKey: String) {
        self.cacheKey = cacheKey
    }
    
    override var hash: Int {cacheKey.hashValue}
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let value = object as? CacheKey else {
            return false
        }
        
        return value.cacheKey == cacheKey
    }
}
