//
//  JSONValue.swift
//  OBSwift
//
//  Created by Edon Valdman on 12/31/21.
//

import Foundation

/// A container for untyped JSON values.
@dynamicMemberLookup
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
    
    public subscript(dynamicMember member: String) -> JSONValue? {
        guard case .object(let dict) = self else { return nil }
        return dict[member]
    }
    
    public subscript(dynamicMember member: Int) -> JSONValue? {
        guard case .array(let array) = self else { return nil }
        return array[member]
    }
}
