import XCTest
@testable import ApkParser

final class ApkParserTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ApkParser().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
