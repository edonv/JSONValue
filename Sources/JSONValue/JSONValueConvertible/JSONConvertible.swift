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

extension Array: JSONConvertible where Element: JSONConvertible {
    public var json: JSONValue { .array(self.map(\.json)) }
    public init?(json: JSONValue) {
        guard case .array(let array) = json else { return nil }
        let elements = array.compactMap(Element.init(json:))
        guard elements.count == array.count else { return nil }
        self = elements

    }
}

extension Optional: JSONConvertible where Wrapped: JSONConvertible {
    public var json: JSONValue { self?.json ?? .null }
    public init(json: JSONValue) {
        if case .null = json {
            self = nil
        } else {
            self = Wrapped(json: json)
        }
    }
}

// MARK: - Converting JSONValue

extension JSONValue {
    /// Gets the value for the provided key and tries to convert it to the provided convertible type, if the receiver is a JSON object.
    ///
    /// If the receiver is a JSON object, it will access the value for the provided key and try to return it as the provided type. If not an object or the conversion fails, it returns `nil`.
    /// - Parameters:
    ///   - key: The key for which to look up a value.
    ///   - type: The ``JSONConvertible`` type to try to convert the value to.
    /// - Returns: If the receiver is an object, the `key` is present in the object, and the value is converted successfully to the provided type, the converted value. Otherwise, `nil`.
    public subscript<T: JSONConvertible>(_ key: String, as type: T.Type) -> T? {
        guard let value = self[nilIfNotObject: key] else { return nil }
        return .init(json: value)
    }
    
    /// Gets the element for the provided index and tries to convert it to the provided convertible type, if the receiver is a JSON array.
    ///
    /// If the receiver is a JSON array, it will access the element for the provided index and try to return it as the provided type. If not an array or the conversion fails, it returns `nil`.
    /// - Parameters:
    ///   - index: The position of the element to access.
    ///   - type: The ``JSONConvertible`` type to try to convert the element to.
    /// - Returns: If the receiver is an array, the `index` exists, and the element at the `index` is converted successfully to the provided type, the converted element. Otherwise, `nil`.
    public subscript<T: JSONConvertible>(_ index: Int, as type: T.Type) -> T? {
        guard let value = self[safelyNilIfNotArray: index] else { return nil }
        return .init(json: value)
    }
}
