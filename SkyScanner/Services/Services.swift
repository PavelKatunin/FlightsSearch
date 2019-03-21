import Foundation

protocol Services {
    
    var flightTasksBuilder: FlightRequestTasksBuilder { get }
    var httpService: HTTPService { get }
    var environment: Environment { get }
    
}
