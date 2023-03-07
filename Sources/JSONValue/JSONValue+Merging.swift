//
//  JSONValue+Merging.swift
//  
//
//  Created by Edon Valdman on 3/7/23.
//

import Foundation

extension JSONValue {
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
