import XCTest
@testable import AnchorockKit

final class AnchorockKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AnchorockKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
