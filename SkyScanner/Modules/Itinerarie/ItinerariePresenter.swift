import UIKit

final class ItinerariePresenter {

    fileprivate weak var view: ItinerarieViewProtocol!
    fileprivate let router: ItinerarieWireframeProtocol
    
    private var itinerarieModel: Itinerarie? {
        didSet {
            if let itinerarieModel = itinerarieModel {
                view.outboundLeg = itinerarieModel.outbound
                view.inboundLeg = itinerarieModel.inbound
                view.rightBottomTitleText = "£\(itinerarieModel.price)"
                let segmentsCount = itinerarieModel.outbound.segments.count +
                                    (itinerarieModel.inbound?.segments.count ?? 0)
                view.rightBottomDescriptionText = "\(segmentsCount) bookings required"
                view.rating = itinerarieModel.rating
                view.tagsText = composeTagsStringFrom(itinerarie: itinerarieModel)
            }
            else {
                view.rightBottomTitleText = nil
                view.rightBottomDescriptionText = nil
                view.tagsText = nil
                view.outboundLeg = nil
                view.inboundLeg = nil
            }
        }
    }
    
    weak var output: ItinerarieOutput?

    init(view: ItinerarieViewProtocol, router: ItinerarieWireframeProtocol) {
        self.view = view
        self.router = router
    }
    
    private func composeTagsStringFrom(itinerarie: Itinerarie) -> String? {
        var tagsArray = [String]()
        if itinerarie.isLowestPrice ?? false {
            tagsArray.append("Cheapest")
        }
        
        if itinerarie.isShortest ?? false {
            tagsArray.append("Shortest")
        }
        
        return tagsArray.count == 0 ? nil : tagsArray.reduce("", { (result, tag) -> String in
            return result + " " + tag
        })
    }
    
}

extension ItinerariePresenter: ItinerarieViewPresenter {
    
}

extension ItinerariePresenter: ItinerarieIO {
    
    var itinerarie: Itinerarie? {
        get {
            return itinerarieModel
        }
        set {
            itinerarieModel = newValue
        }
    }
    
    
}
