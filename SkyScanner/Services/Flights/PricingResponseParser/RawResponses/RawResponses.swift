import Foundation

struct PricingRawResponse: Decodable {
    var itineraries: [ItinerarieRawResponse]
    var legs: [LegRawResponse]?
    var segments: [SegmentRawResponse]?
    var places: [PlaceRawResponse]?
    var carriers: [CarrierRawResponse]?
    var operatingCarriers: [CarrierRawResponse]?
    var status: String
}

struct ItinerarieRawResponse: Decodable {
    var outboundLegId: String?
    var inboundLegId: String?
    var pricingOptions: [PricingOptionRawResponse]?
    
    var price: Float? {
        return pricingOptions?.first?.price
    }
    
}

struct LegRawResponse: Decodable {
    var id: String
    var segmentIds: [Int]
    var originStation: Int
    var destinationStation: Int
    var duration: Int
    var departure: Date
    var arrival: Date
    var stops: [Int]
}

struct SegmentRawResponse: Decodable {
    var id: Int
    var originStation: Int
    var destinationStation: Int
    var duration: Int
    var departureDateTime: Date?
    var arrivalDateTime: Date?
    var carrier: Int
    var operatingCarrier: Int
}

struct AgentRawResponse: Decodable {
    var id: Int
    var name: String
    var imageUrl: String
}

struct PlaceRawResponse: Decodable {
    var id: Int
    var code: String
    var name: String
}

struct CarrierRawResponse: Decodable {
    var id: Int
    var code: String
    var name: String
    var imageUrl: String?
    var displayCode: String
}

struct PricingOptionRawResponse: Decodable {
    var price: Float
}
