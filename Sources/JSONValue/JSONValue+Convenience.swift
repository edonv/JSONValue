//
//  JSONValue+Convenience.swift
//  
//
//  Created by Edon Valdman on 3/7/23.
//

import Foundation

extension JSONValue {
    var isNil: Bool {
        guard case .null = self else { return false }
        return true
    }
}
