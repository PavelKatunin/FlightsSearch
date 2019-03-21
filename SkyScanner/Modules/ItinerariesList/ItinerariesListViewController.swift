import UIKit

final class ItinerariesListViewController: UIViewController, ItinerariesListViewProtocol {
    
    let cellId = "Cell"
    
    var itineraries: [Itinerarie]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    func show(loading: Bool) {
        if loading {
            activityIndicator.startAnimating()
        }
        else {
            activityIndicator.stopAnimating()
        }
    }
    
	var presenter: ItinerariesListViewPresenter!

    var tableView: UITableView {
        return self.view as! UITableView
    }
    
    private var style: Style
    
    //MARK: - View life cycle
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        tableView.register(ItinerarieCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func loadView() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).activate()
        activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).activate()
        self.view = tableView
    }
    
    //MARK: - Initialization
    
    init(style: Style) {
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ItinerariesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return itineraries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ItinerarieCell
        cell.module.input.itinerarie = itineraries?[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension ItinerariesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
}
