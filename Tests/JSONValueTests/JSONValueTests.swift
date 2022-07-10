import XCTest
@testable import JSONValue

final class JSONValueTests: XCTestCase {
    func testInitFromString() {
        XCTAssertEqual("Hello, World!" as JSONValue, "Hello, World!")
    }

    static var allTests = [
        ("testInitFromString", testInitFromString),
    ]
}
