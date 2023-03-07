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
    case number(Double)
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
}
