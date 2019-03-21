import Foundation

struct Leg {
    var segments: [Segment]
    var duration: Int
    var departureTime: Date
    var arrivalTime: Date
    var origin: String
    var destination: String
    var carrier: String?
    var carrierImageURL: URL?
    var isDirect: Bool
}
