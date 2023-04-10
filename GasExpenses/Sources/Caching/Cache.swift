//
//  Cache.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 10/04/2023.
//

import Foundation

final class Cache: NSObject {
    
    static let shared = Cache()
    private let cache = NSCache<CacheKey, CacheEntry<Codable>>()
    
    func cache(object: Codable,
               key: String) {
        cache.setObject(CacheEntry(item: object),
                        forKey: CacheKey(key))
    }
    
    func getCacheEntry<T: Codable>(key: String,
                                   object: T.Type) -> T? {
        guard let cachedObject = cache.object(forKey: CacheKey(key)) else { return nil }
        
        if let convertedObject = cachedObject.item as? T {
            return convertedObject
        }
        
        return nil
    }
    
    func invalidate(key: String) {
        cache.removeObject(forKey: CacheKey(key))
    }
}
