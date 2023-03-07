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
    
    var isNil: Bool {
        guard case .null = self else { return false }
        return true
    }
}
