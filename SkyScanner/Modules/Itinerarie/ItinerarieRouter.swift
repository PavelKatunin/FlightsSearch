import UIKit

final class ItinerarieRouter: ItinerarieWireframeProtocol {
    
    fileprivate weak var view: (UIView & ItinerarieViewProtocol)?
    
    static func createModule(output: ItinerarieOutput? = nil) -> MVP<UIView, ItinerarieIO> {
        let view: ItinerarieView = ItinerarieView(style: SkyScannerStyle(),
                                                  frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        let router = ItinerarieRouter()
        let presenter = ItinerariePresenter(view: view, router: router)
        
        view.presenter = presenter
        router.view = view
        presenter.output = output
        
        return MVP(view: view, input: presenter)
    }
}
