//
//  JSONConvertible.swift
//
//
//  Created by Edon Valdman on 4/7/24.
//

import Foundation

// MARK: - JSONConvertible

/// This protocol allows for direct conversion to and from raw ``JSONValue``.
public protocol JSONConvertible {
    var json: JSONValue { get }
    init?(json: JSONValue)
}

// MARK: - Core JSONConvertible Types

//extension JSONValue: JSONConvertible {
//    public var json: JSONValue { self }
//    public init(json: JSONValue) { self = json }
//}

extension String: JSONConvertible {
    public var json: JSONValue { .string(self) }
    public init?(json: JSONValue) {
        guard case .string(let string) = json else { return nil }
        self = string
    }
}

extension Double: JSONConvertible {
    public var json: JSONValue { .number(self) }
    public init?(json: JSONValue) {
        guard case .number(let double) = json else { return nil }
        self = double
    }
}

extension Bool: JSONConvertible {
    public var json: JSONValue { .bool(self) }
    public init?(json: JSONValue) {
        guard case .bool(let bool) = json else { return nil }
        self = bool
    }
}

extension Dictionary: JSONConvertible where Key == String, Value == JSONValue {
    public var json: JSONValue { .object(self) }
    public init?(json: JSONValue) {
        guard case .object(let dict) = json else { return nil }
        self = dict
    }
}

extension Array: JSONConvertible where Element == JSONValue {
    public var json: JSONValue { .array(self) }
    public init?(json: JSONValue) {
        guard case .array(let array) = json else { return nil }
        self = array
    }
}

extension Optional: JSONConvertible where Wrapped == JSONValue {
    public var json: JSONValue { self ?? .null }
    public init(json: JSONValue) {
        if case .null = json {
            self = nil
        } else {
            self = json
        }
    }
}

// MARK: - Converting JSONValue

extension JSONValue {
    private var coreConvertible: any JSONConvertible {
        switch self {
        case .string(let string):
            return string
        case .number(let double):
            return double
        case .bool(let bool):
            return bool
        case .object(let dictionary):
            return dictionary
        case .array(let array):
            return array
        case .null:
            return JSONValue?.none as any JSONConvertible
        }
    }
    
    public subscript<T: JSONConvertible>(_ key: String, as type: T.Type) -> T? {
        let value = self[nilIfNotObject: key]?.coreConvertible
        return value as? T
    }
    
    public subscript<T: JSONConvertible>(_ index: Int, as type: T.Type) -> T? {
        let value = self[safelyNilIfNotArray: index]?.coreConvertible
        return value as? T
    }
}