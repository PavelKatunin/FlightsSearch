import Foundation

struct Itinerarie {
    var outbound: Leg
    var inbound: Leg?
    var price: Float
    var isLowestPrice: Bool?
    var isShortest: Bool?
    var rating: Float?
}
