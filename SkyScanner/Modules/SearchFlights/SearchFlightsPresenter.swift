import UIKit

final class SearchFlightsPresenter {

    fileprivate weak var view: SearchFlightsViewProtocol!
    fileprivate let router: SearchFlightsWireframeProtocol
    
    weak var output: SearchFlightsOutput?

    init(view: SearchFlightsViewProtocol, router: SearchFlightsWireframeProtocol) {
        self.view = view
        self.router = router
    }
}

extension SearchFlightsPresenter: SearchFlightsViewPresenter {
    func viewLoaded() {

    }
}

extension SearchFlightsPresenter: SearchFlightsIO {
    
}
