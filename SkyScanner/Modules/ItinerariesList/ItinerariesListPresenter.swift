import UIKit

final class ItinerariesListPresenter {

    fileprivate weak var view: ItinerariesListViewProtocol!
    fileprivate let router: ItinerariesListWireframeProtocol
    private let tasksBuilder: FlightRequestTasksBuilder
    
    weak var output: ItinerariesListOutput?

    init(view: ItinerariesListViewProtocol,
         router: ItinerariesListWireframeProtocol,
         tasksBuilder: FlightRequestTasksBuilder) {
        self.view = view
        self.router = router
        self.tasksBuilder = tasksBuilder
    }
    
    let dayInterval: TimeInterval = 24 * 60 * 60
    
    var poller: FlightsPoller?
    
}

extension ItinerariesListPresenter: ItinerariesListViewPresenter {
    func viewLoaded() {
        view?.title = "ItinerariesList"
        let day = nextMonday()
        let nextDay = day.addingTimeInterval(dayInterval)
        view?.show(loading: true)
        let task =
            tasksBuilder.buildRetrivingPollingSessionIdTask(origin: "EDI",
                                                            destination: "LHR",
                                                            outbound: day,
                                                            inbound: nextDay) { (result) in
            DispatchQueue.main.async {
                self.view?.show(loading: false)
            }
            switch result {
            case .success(let url):
               self.loadItinerariesBy(url: url)
            case .failure(let error):
                print(error)
            }
        }
        task.resume()
    }
    
    func nextMonday() -> Date {
        return Date().next(Date.Weekday.monday)
    }
    
    
    func loadItinerariesBy(url: URL) {
        DispatchQueue.main.async {
            self.poller = FlightsPoller(sessionURL: url, tasksBuilder: self.tasksBuilder)
            self.poller?.observer = self
            self.poller?.run()
        }
    }
    
}

extension ItinerariesListPresenter: FlightsPollerObserver {
    
    func poller(_ poller: FlightsPoller, didReturnItineraries itineraries: [Itinerarie]) {
        DispatchQueue.main.async {
            self.view.itineraries = itineraries
        }
    }
    
}

extension ItinerariesListPresenter: ItinerariesListIO {
    
}
