//
//  JSONValue.swift
//  OBSwift
//
//  Created by Edon Valdman on 12/31/21.
//

import Foundation

@dynamicMemberLookup
public enum JSONValue: Hashable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: JSONValue])
    case array([JSONValue])
    case null
    
    public static let emptyObject = JSONValue.object([:])
    
    public subscript(dynamicMember member: String) -> JSONValue? {
        guard case .object(let dict) = self else { return nil }
        return dict[member]
    }
    
    public subscript(dynamicMember member: Int) -> JSONValue? {
        guard case .array(let array) = self else { return nil }
        return array[member]
    }
    
    @available(*, unavailable, renamed: "mergingObject(with:)")
    public func mergedObject(with newObject: JSONValue) throws -> JSONValue {
        try self.mergingObject(with: newObject)
    }
    
    public func mergingObject(with newObject: JSONValue) throws -> JSONValue {
        guard case .object(let old) = self,
              case .object(let new) = newObject else { throw JSONErrors.failedToDecodeObject }
        return JSONValue.object(old.merging(new, uniquingKeysWith: { o, n in o }))
    }
    
    public mutating func mergeObject(with newObject: JSONValue) throws {
        self = try mergingObject(with: newObject)
    }
}
