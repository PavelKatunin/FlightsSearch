import Foundation

protocol FlightRequestTasksBuilder {
    
    func buildRetrivingPollingSessionIdTask(origin: String,
                                            destination: String,
                                            outbound: Date,
                                            inbound: Date,
                                            completion: @escaping (Result<URL>) -> Void) -> URLSessionDataTask
    
    func buildGetFlightsTask(sessionURL: URL,
                             completion: @escaping (Result<([Itinerarie], Bool)>) -> Void) -> URLSessionDataTask
    
}
