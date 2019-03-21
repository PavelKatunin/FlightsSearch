import Foundation

protocol FlightsPollerObserver: class {
    
    func poller(_ poller: FlightsPoller, didReturnItineraries itineraries: [Itinerarie])
    
}

class GetItinerariesOperation: AsynchronousOperation {
    
    let sessionURL: URL
    let tasksBuilder: FlightRequestTasksBuilder
    var result: Result<([Itinerarie], Bool)>?
    
    init(sessionURL: URL,
         tasksBuilder: FlightRequestTasksBuilder) {
        self.sessionURL = sessionURL
        self.tasksBuilder = tasksBuilder
    }
    
    override func execute() {
        let task = tasksBuilder.buildGetFlightsTask(sessionURL: sessionURL) { [weak self] (result) in
            self?.result = result
            self?.finish()
        }
        task.resume()
    }
    
}

class FlightsPoller {
    
    weak var observer: FlightsPollerObserver?
    
    let sessionURL: URL
    let tasksBuilder: FlightRequestTasksBuilder
    var timer: Timer?
    let delta: TimeInterval = 3
    
    lazy var queue: OperationQueue = {
       let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    init(sessionURL: URL,
         tasksBuilder: FlightRequestTasksBuilder) {
        self.sessionURL = sessionURL
        self.tasksBuilder = tasksBuilder
    }
    
    func run() {
        timer = Timer.scheduledTimer(timeInterval: delta,
                                     target: self,
                                     selector: #selector(addOperation(_:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        queue.cancelAllOperations()
    }
    
    @objc private func addOperation(_ sender: AnyObject) {
        let operation = GetItinerariesOperation(sessionURL: sessionURL,
                                                tasksBuilder: tasksBuilder)
        operation.completionBlock = { [weak self, weak operation] in
            if let operation = operation,
               let result = operation.result {
                switch result {
                case .success(let itinerariesResult):
                    if let self = self {
                        self.observer?.poller(self, didReturnItineraries: itinerariesResult.0)
                        if itinerariesResult.1 {
                            self.stop()
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        queue.addOperation(operation)
    }
    
}
