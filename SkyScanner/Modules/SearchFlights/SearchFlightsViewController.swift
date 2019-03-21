import UIKit

final class SearchFlightsViewController: UIViewController, SearchFlightsViewProtocol {

	var presenter: SearchFlightsViewPresenter!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_action_share"),
                                                                 style: .plain,
                                                                 target: nil,
                                                                 action: nil)
    }
    
    override func loadView() {
        let module = ItinerariesListRouter.createModule()
        let view = UIView()
        let listController = module.view
        listController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(listController)
        view.addSubview(listController.view)
        listController.view.activateConstraintsToWrapSuperview()
        listController.didMove(toParent: self)
        self.view = view
    }

}
