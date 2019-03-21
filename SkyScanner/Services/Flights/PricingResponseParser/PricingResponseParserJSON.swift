import Foundation

extension PricingRawResponse {
    
    // To be able to perform search by id O(1)
    class IndexTable {
        var segmentsTable = [Int : SegmentRawResponse]()
        var legsTable = [String : LegRawResponse]()
        var placesTable = [Int : PlaceRawResponse]()
        var carriersTable = [Int : CarrierRawResponse]()
    }
    
    func createIndexTable() -> IndexTable {
        let indexTable = IndexTable()
        legs?.forEach { (legResponse) in
            indexTable.legsTable[legResponse.id] = legResponse
        }
        segments?.forEach { (segmentResponse) in
            indexTable.segmentsTable[segmentResponse.id] = segmentResponse
        }
        places?.forEach { (placeResponse) in
            indexTable.placesTable[placeResponse.id] = placeResponse
        }
        carriers?.forEach({ (carrier) in
            indexTable.carriersTable[carrier.id] = carrier
        })
        return indexTable
    }
    
}

class PricingResponseParserJSON: PricingResponseParser {
    
    struct AnyKey: CodingKey {
        
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue.lowercasingFirstLetter()
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            self.stringValue = String(intValue)
            self.intValue = intValue
        }
    }
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .custom({ keys in
            if let component = keys.last?.stringValue,
                let key = AnyKey(stringValue: component) {
                return key
            }
            
            return AnyKey(stringValue: "")!
        })
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let date = formatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Cannot decode date string \(dateString)")
        })
        return decoder
    }()
    
    func itinerariesFrom(data: Data) throws -> (itineraries: [Itinerarie] , done: Bool) {
        let pricingReponse = try decoder.decode(PricingRawResponse.self, from: data)
        let indexTable = pricingReponse.createIndexTable()
        let itineraries = createItinerariesWith(rawItineraries: pricingReponse.itineraries,
                                                indexTable: indexTable)
        return (itineraries, pricingReponse.status == "UpdatesComplete")
    }
    
    private func createItinerariesWith(rawItineraries: [ItinerarieRawResponse],
                                       indexTable: PricingRawResponse.IndexTable) -> [Itinerarie] {
        
        var itineraries = [Itinerarie]()
        
        guard rawItineraries.count > 0 else { return itineraries }
        
        let minPrice = minPriceFrom(rawItineraries: rawItineraries)
        var legPairs = [(outbound: Leg, inbound: Leg?)]()
        
        rawItineraries.forEach { (itinerarieResponse) in
            
            if let outboundLegId = itinerarieResponse.outboundLegId,
                let outboundLegResponse = indexTable.legsTable[outboundLegId],

                let outboundLeg = createLegWith(rawLeg: outboundLegResponse,
                                                indexTable: indexTable) {
                
                    var inboundLeg: Leg?
                    if let inboundLegId = itinerarieResponse.inboundLegId,
                        let inboundLegResponse = indexTable.legsTable[inboundLegId] {
                        inboundLeg = createLegWith(rawLeg: inboundLegResponse,
                                               indexTable: indexTable)
                        legPairs.append((outbound: outboundLeg, inbound: inboundLeg))
                    }
            }
        }
        
        let minDuration = minDurationFrom(legPairs: legPairs)
        
        for (index, legPair) in legPairs.enumerated() {
            if let price = rawItineraries[index].pricingOptions?.first?.price {
                let isShortest = minDuration == legPair.outbound.duration + (legPair.inbound?.duration ?? 0)
                let rating = calculateRating(minDuration: minDuration,
                                             minPrice: minPrice,
                                             price: price,
                                             legPair: legPair)
                let itinerarie = Itinerarie(outbound: legPair.outbound,
                                            inbound: legPair.inbound,
                                            price: price,
                                            isLowestPrice: abs(price - (minPrice ?? 0)) < 0.0001,
                                            isShortest: isShortest,
                                            rating: rating)
                itineraries.append(itinerarie)
            }
        }
        
        return itineraries
    }
    
    private func calculateRating(minDuration: Int?,
                                 minPrice: Float?,
                                 price: Float,
                                 legPair: (outbound: Leg, inbound: Leg?)) -> Float {
        let maxRating: Float = 10.0
        var rating = maxRating
        
        if let minDuration = minDuration,
            let minPrice = minPrice {
            let duration = legPair.outbound.duration + (legPair.inbound?.duration ?? 0)
            rating = maxRating * (minPrice / price) * (Float(minDuration) / Float(duration))
        }
        
        return rating
    }
    
    private func minPriceFrom(rawItineraries: [ItinerarieRawResponse]) -> Float? {
        var minPrice: Float?
        if let price = rawItineraries.first?.price {
            minPrice = rawItineraries.reduce(price) { (result, rawItinerarie) -> Float in
                return min(result, rawItinerarie.price ?? MAXFLOAT)
            }
        }
        return minPrice
    }
    
    private func minDurationFrom(legPairs: [(outbound: Leg, inbound: Leg?)]) -> Int? {
        var minDuration: Int?
        if  let firstPair = legPairs.first {
            let duration = firstPair.outbound.duration + (firstPair.inbound?.duration ?? 0)
            minDuration = legPairs.reduce(duration) { (result, pair) -> Int in
                return min(result, pair.outbound.duration + (pair.inbound?.duration ?? 0))
            }
        }
        return minDuration
    }
    
    private func createLegWith(rawLeg: LegRawResponse,
                               indexTable: PricingRawResponse.IndexTable) -> Leg? {
        var segments = [Segment]()
        rawLeg.segmentIds.forEach { (segmentId) in
            if let segmentResponse = indexTable.segmentsTable[segmentId],
                let segment = createSegmentWith(rawSegment: segmentResponse,
                                                indexTable: indexTable) {
                segments.append(segment)
            }
        }
        
        guard let origin = indexTable.placesTable[rawLeg.originStation]?.code,
              let destination = indexTable.placesTable[rawLeg.destinationStation]?.code,
              let carrier = segments.first?.carrier else {
            return nil
        }
        
        let leg = Leg(segments: segments,
                      duration: rawLeg.duration,
                      departureTime: rawLeg.departure,
                      arrivalTime: rawLeg.arrival,
                      origin: origin,
                      destination: destination,
                      carrier: carrier,
                      carrierImageURL: segments.first?.carrierImageURL,
                      isDirect: segments.count == 1)
        return leg
    }
    
    private func createSegmentWith(rawSegment: SegmentRawResponse,
                                   indexTable: PricingRawResponse.IndexTable) -> Segment? {
        
        guard let originString = indexTable.placesTable[rawSegment.originStation]?.code,
            let destinationString = indexTable.placesTable[rawSegment.destinationStation]?.code,
            let departureTime = rawSegment.departureDateTime,
            let arrivalTime = rawSegment.arrivalDateTime
            else {
                return nil
        }

        let duration = rawSegment.duration
        
        var carrierName: String?
        var carrierImageUrl: URL?
        
        if  let carrier = indexTable.carriersTable[rawSegment.carrier] {
            carrierName = carrier.name
            if  let imageUrlString = carrier.imageUrl {
                carrierImageUrl = URL(string: imageUrlString)
            }
        }

        let segment = Segment(origin: originString,
                              destination: destinationString,
                              departureTime: departureTime,
                              arrivalTime: arrivalTime,
                              carrier: carrierName,
                              duration: duration,
                              carrierImageURL: carrierImageUrl)
        return segment
    }
    
}
