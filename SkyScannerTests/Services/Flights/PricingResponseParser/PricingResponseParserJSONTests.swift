import XCTest

@testable import SkyScanner
class PricingResponseParserJSONTests: XCTestCase {

    func testSuccessParsing() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "successPrices", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let parser = PricingResponseParserJSON()
        let result = try! parser.itinerariesFrom(data: data)
        XCTAssertEqual(result.done, true)
        XCTAssertEqual(result.itineraries.count, 18)
        for itinerarie in result.itineraries {
            XCTAssertNotNil(itinerarie.inbound)
        }
    }

}
