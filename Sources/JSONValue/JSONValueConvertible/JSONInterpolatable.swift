//
//  JSONInterpolatable.swift
//  
//
//  Created by Edon Valdman on 4/7/24.
//

import Foundation

// MARK: - JSONInterpolatable

/// This protocol allows for complex types to be more easily converted to and from raw ``JSONValue`` by first converting to/from an in-between "core" type (one that conforms to ``JSONConvertible``).
public protocol JSONInterpolatable: JSONConvertible {
    associatedtype CoreJSONValue: JSONConvertible
    var coreJSON: CoreJSONValue { get }
    init?(coreJSON: CoreJSONValue)
}

extension JSONInterpolatable {
    public var json: JSONValue { coreJSON.json }
    public init?(json: JSONValue) {
        guard let core = CoreJSONValue(json: json) else { return nil }
        self.init(coreJSON: core)
    }
}

// MARK: - Adding Convenience Types

// MARK: Core - String

extension Substring: JSONInterpolatable {
    public var coreJSON: String { .init(self) }
    public init?(coreJSON: String) {
        self.init(coreJSON)
    }
}

// MARK: Core - Numbers

extension Int: JSONInterpolatable {
    public var coreJSON: Double { .init(self) }
    public init(coreJSON: Double) {
        self.init(coreJSON)
    }
}

extension Int8: JSONInterpolatable {
    public var coreJSON: Double { .init(self) }
    public init(coreJSON: Double) {
        self.init(coreJSON)
    }
}

extension Int16: JSONInterpolatable {
    public var coreJSON: Double { .init(self) }
    public init(coreJSON: Double) {
        self.init(coreJSON)
    }
}

extension UInt: JSONInterpolatable {
    public var coreJSON: Double { .init(self) }
    public init(coreJSON: Double) {
        self.init(coreJSON)
    }
}

extension UInt8: JSONInterpolatable {
    public var coreJSON: Double { .init(self) }
    public init(coreJSON: Double) {
        self.init(coreJSON)
    }
}

extension UInt16: JSONInterpolatable {
    public var coreJSON: Double { .init(self) }
    public init(coreJSON: Double) {
        self.init(coreJSON)
    }
}

extension UInt32: JSONInterpolatable {
    public var coreJSON: Double { .init(self) }
    public init(coreJSON: Double) {
        self.init(coreJSON)
    }
}

extension Float: JSONInterpolatable {
    public var coreJSON: Double { .init(self) }
    public init(coreJSON: Double) {
        self.init(coreJSON)
    }
}


@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension Float16: JSONInterpolatable {
    public var coreJSON: Double { .init(self) }
    public init(coreJSON: Double) {
        self.init(coreJSON)
    }
}

//extension Float80: JSONInterpolatable {
//    public var coreJSON: Double { .init(self) }
//    public init(coreJSON: Double) {
//        self.init(coreJSON)
//    }
//}
