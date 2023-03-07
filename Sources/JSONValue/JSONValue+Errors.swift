//
//  JSONValue+Errors.swift
//  
//
//  Created by Edon Valdman on 3/7/23.
//

import Foundation

public enum JSONErrors: Error {
    case failedToEncodeObject
    case failedToDecodeObject
}
