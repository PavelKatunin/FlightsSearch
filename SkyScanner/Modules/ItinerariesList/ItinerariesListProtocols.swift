import Foundation

// MARK: - Wireframe

protocol ItinerariesListWireframeProtocol: class {

}

// MARK: - Presenter

protocol ItinerariesListViewPresenter: class {
    func viewLoaded()
}

typealias ItinerariesListPresenterProtocol = ItinerariesListViewPresenter

// MARK: - View

protocol ItinerariesListViewProtocol: class {
    var title: String? { set get }
    var itineraries: [Itinerarie]? { set get }
    func show(loading: Bool)
}

// MARK: - IO

protocol ItinerariesListInput: class {
    
}

protocol ItinerariesListOutput: class {
    
}

protocol ItinerariesListIO: ItinerariesListInput {
    var output: ItinerariesListOutput? { set get }
}
