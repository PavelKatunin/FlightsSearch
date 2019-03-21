import UIKit

final class LegRouter: LegWireframeProtocol {
    
    fileprivate weak var view: (UIView & LegViewProtocol)?
    
    static func createModule(output: LegOutput? = nil) -> MVP<UIView, LegIO> {
        let view: LegView = LegView(style: SkyScannerStyle(), frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        let router = LegRouter()
        let presenter = LegPresenter(view: view,
                                     router: router,
                                     http: GlobalServices.shared.httpService)
        
        view.presenter = presenter
        router.view = view
        presenter.output = output
        
        return MVP(view: view, input: presenter)
    }
}
