import UIKit

final class SearchFlightsRouter: SearchFlightsWireframeProtocol {
    
    fileprivate weak var view: (UIViewController & SearchFlightsViewProtocol)?
    
    static func createModule(output: SearchFlightsOutput? = nil) -> MVP<UIViewController, SearchFlightsIO> {
        let view = SearchFlightsViewController(nibName: nil, bundle: nil)
        let router = SearchFlightsRouter()
        let presenter = SearchFlightsPresenter(view: view, router: router)
        
        view.presenter = presenter
        router.view = view
        presenter.output = output
        
        return MVP(view: view, input: presenter)
    }
}
