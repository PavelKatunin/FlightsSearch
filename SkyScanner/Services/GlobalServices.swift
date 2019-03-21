import Foundation

class GlobalServices: Services {
    
    static let shared = GlobalServices()
    
    var flightTasksBuilder: FlightRequestTasksBuilder
    
    var httpService: HTTPService
    
    var environment: Environment
    
    init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 3
        sessionConfig.timeoutIntervalForResource = 3
        let session = URLSession(configuration: sessionConfig)
        self.environment = EnvironmentProduction()
        self.httpService = HTTPServiceRemote()
        self.flightTasksBuilder = FlightRequestTasksBuilderRemote(environment: environment,
                                                                  session: session,
                                                                  pricingParser: PricingResponseParserJSON())
    }
    
}
