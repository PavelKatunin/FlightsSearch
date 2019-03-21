import UIKit

final class ItinerariesListRouter: ItinerariesListWireframeProtocol {
    
    fileprivate weak var view: (UIViewController & ItinerariesListViewProtocol)?
    
    static func createModule(output: ItinerariesListOutput? = nil) -> MVP<UIViewController, ItinerariesListIO> {
        let view = ItinerariesListViewController(style: SkyScannerStyle())
        let router = ItinerariesListRouter()
        
        let tasksBuidler = GlobalServices.init().flightTasksBuilder
        let presenter = ItinerariesListPresenter(view: view, router: router, tasksBuilder: tasksBuidler)
        
        view.presenter = presenter
        router.view = view
        presenter.output = output
        
        return MVP(view: view, input: presenter)
    }
}
