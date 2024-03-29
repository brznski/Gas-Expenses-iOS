//
//  Configuration.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 15/04/2023.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum API {
    static var baseURL: URL {
        // swiftlint:disable force_try
        return try! URL(string: "http://" + Configuration.value(for: "BASE_URL"))!
    }
}

enum Storage {
    static var usesOnlineServices: Bool {
        return try! Configuration.value(for: "USE_ONLINE_SERVICES")
    }
}
