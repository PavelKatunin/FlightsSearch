import XCTest


@testable import SkyScanner
class HoursMinutesFormatterTests: XCTestCase {
    
    let formatter = HoursMinutesFormatter()

    func testHoursAndMinutes() {
        XCTAssertEqual(formatter.stringFrom(minutesNumber: 75), "1h 15m")
    }
    
    func testMnutes() {
        XCTAssertEqual(formatter.stringFrom(minutesNumber: 13), "13m")
    }
    
    func testHours() {
        XCTAssertEqual(formatter.stringFrom(minutesNumber: 60), "1h") 
    }

}
