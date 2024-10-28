import XCTest

@testable import Utility

final class UtilityTests: XCTestCase {
    
    func testFormattedWithSuffix() {
        XCTAssertEqual(1_000_000.formattedWithSuffix, "1.0m")
        XCTAssertEqual(1_500_000.formattedWithSuffix, "1.5m")
        XCTAssertEqual(2_000_000.formattedWithSuffix, "2.0m")
        XCTAssertEqual(999_999_999.formattedWithSuffix, "999.9m")
        
        XCTAssertEqual(1_000.formattedWithSuffix, "1.0k")
        XCTAssertEqual(1_500.formattedWithSuffix, "1.5k")
        XCTAssertEqual(10_000.formattedWithSuffix, "10.0k")
        XCTAssertEqual(999_999.formattedWithSuffix, "999.9k")
        
        XCTAssertEqual(999.formattedWithSuffix, "999")
        XCTAssertEqual(100.formattedWithSuffix, "100")
        XCTAssertEqual(0.formattedWithSuffix, "0")
    }
}
