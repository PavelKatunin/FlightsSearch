import Foundation

// MARK: - Wireframe

protocol ItinerarieWireframeProtocol: class {

}

// MARK: - Presenter

protocol ItinerarieViewPresenter: class {
    
}

typealias ItinerariePresenterProtocol = ItinerarieViewPresenter

// MARK: - View

protocol ItinerarieViewProtocol: class {
    var outboundLeg: Leg? { set get }
    var inboundLeg: Leg? { set get }
    var tagsText: String? { set get }
    var rightBottomTitleText: String? { set get}
    var rightBottomDescriptionText: String? { set get}
    var rating: Float? { set get }
}

// MARK: - IO

protocol ItinerarieInput: class {
    var itinerarie: Itinerarie? { set get }
}

protocol ItinerarieOutput: class {

}

protocol ItinerarieIO: ItinerarieInput {
    var output: ItinerarieOutput? { set get }
}
