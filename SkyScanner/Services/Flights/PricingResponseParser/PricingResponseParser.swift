import Foundation

protocol PricingResponseParser {
    
    func itinerariesFrom(data: Data) throws -> (itineraries: [Itinerarie] , done: Bool)
    
}
