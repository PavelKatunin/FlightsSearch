import Foundation

struct Segment {
    var origin: String
    var destination: String
    var departureTime: Date
    var arrivalTime: Date
    var carrier: String?
    var duration: Int
    var carrierImageURL: URL?
}
