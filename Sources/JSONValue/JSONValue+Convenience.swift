//
//  JSONValue+Convenience.swift
//  
//
//  Created by Edon Valdman on 3/7/23.
//

import Foundation

extension JSONValue {
    /// A an empty JSON object for convenience.
    public static let emptyObject = JSONValue.object([:])
    
    public var isNil: Bool {
        guard case .null = self else { return false }
        return true
    }
    
    /// A JSON number value (from any integer).
    public static func int<N: BinaryInteger>(_ value: N) -> JSONValue {
        .number(Double(value))
    }
    
    /// A JSON number value (from any decimal).
    public static func float<N: BinaryFloatingPoint>(_ value: N) -> JSONValue {
        .number(Double(value))
    }
}
