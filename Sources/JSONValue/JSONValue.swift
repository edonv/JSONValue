//
//  JSONValue.swift
//  OBSwift
//
//  Created by Edon Valdman on 12/31/21.
//

import Foundation

/// A container for untyped JSON values.
public enum JSONValue: Hashable {
    /// A JSON string value.
    case string(String)
    
    /// A JSON number value.
    case number(Double)
    
    /// A JSON boolean value.
    case bool(Bool)
    
    /// A JSON object.
    ///
    /// All keys are string values, and all values are recursively other `JSONValue`s.
    case object([String: JSONValue])
    
    /// A JSON array.
    ///
    /// All elemenets of the array are recursively other `JSONValue`s.
    case array([JSONValue])
    
    /// A JSON null value.
    case null
    
    /// A an empty JSON object for convenience.
    public static let emptyObject = JSONValue.object([:])
    
    /// Gets the value for the provided key, if the receiver is a JSON object.
    ///
    /// If the receiver is a JSON object, it will return the value for the provided key (or `nil` if the key is not present in the object). If not an object, it will return the original `JSONValue` itself.
    ///
    /// > Important: If you want it to return `nil` when the receiver is not a JSON object, use ``subscript(nilIfNotObject:)`` instead.
    /// - Parameter key: The key for which to look up a value.
    /// - Returns: If the receiver is an object, the value associated with `key` if `key` is in the object. If `key` is not in the object, `nil`. If not an object, the original receiver.
    public subscript(_ key: String) -> JSONValue? {
        guard case .object(let dict) = self else { return self }
        return dict[key]
    }
    
    /// Gets the value for the provided key, if the receiver is a JSON object.
    ///
    /// If the receiver is a JSON object, it will return the value for the provided key (or `nil` if the key is not present in the object). If it's not an object, it will return `nil`.
    ///
    /// > Important: If you want it to return the original receiver (whatever type of JSON value it is) in that scenario, use ``subscript(_:)-akr3`` instead.
    /// - Parameter key: The key to find in the object.
    /// - Returns: If the receiver is an object, the value associated with `key` if `key` is in the object. Otherwise, `nil`.
    public subscript(nilIfNotObject key: String) -> JSONValue? {
        guard case .object(let dict) = self else { return nil }
        return dict[key]
    }
    
    /// Gets the element for the provided index, if the receiver is a JSON array.
    ///
    /// If the receiver is a JSON array, it will safely access the element for the provided index (returning `nil` if `index` is out of range). If not an array, it will return the original `JSONValue` itself.
    ///
    /// > Important: If you want it to return `nil` when the receiver is not a JSON array, use ``subscript(nilIfNotArray:)`` instead.
    /// - Parameter index: The position of the element to safely access.
    /// - Returns: If the receiver is an array, the value at the `index` position if `index` isn't out of range. If `index` is out of range of the array, `nil`. If not an array, the original receiver.
    public subscript(safely index: Int) -> JSONValue? {
        guard case .array(let array) = self else { return self }
        
        if index >= array.startIndex && index < array.endIndex {
            return array[index]
        } else {
            return nil
        }
    }
    
    /// Gets the element for the provided index, if the receiver is a JSON array.
    ///
    /// If the receiver is a JSON array, it will safely access the element for the provided index (returning `nil` if `index` is out of range). If not an array, `nil`.
    ///
    /// > Important: If you want to return the original receiver itself when the receiver is not a JSON array, use ``subscript(safely:)`` instead.
    /// - Parameter index: The position of the element to safely access.
    /// - Returns: If the receiver is an array, the value at the `index` position if `index` isn't out of range. If `index` is out of range of the array, `nil`. If not an array, `nil`.
    public subscript(safelyNilIfNotArray index: Int) -> JSONValue? {
        guard case .array(let array) = self else { return nil }
        
        if index >= array.startIndex && index < array.endIndex {
            return array[index]
        } else {
            return nil
        }
    }
    
    /// Gets the element for the provided index, if the receiver is a JSON array.
    ///
    /// If the receiver is a JSON array, it will access the element for the provided index. If not an array, it will return the original `JSONValue` itself.
    ///
    /// > Important: If you want to return `nil` when the receiver is not a JSON array, use ``subscript(nilIfNotArray:)`` instead.
    /// - Parameter index: The position of the element to access.
    /// - Returns: If the receiver is an array, the value at the `index` position. If not an array, the original receiver.
    public subscript(_ index: Int) -> JSONValue {
        guard case .array(let array) = self else { return self }
        return array[index]
    }
    
    /// Gets the element for the provided index, if the receiver is a JSON array.
    ///
    /// If the receiver is a JSON array, it will access the element for the provided index. If not an array, `nil`.
    ///
    /// > Important: If you want to return the original receiver itself when the receiver is not a JSON array, use ``subscript(_:)-4etdj`` instead.
    /// - Parameter index: The position of the element to access.
    /// - Returns: If the receiver is an array, the value at the `index` position. If not an array, `nil`.
    public subscript(nilIfNotArray index: Int) -> JSONValue? {
        guard case .array(let array) = self else { return nil }
        return array[index]
    }
}
