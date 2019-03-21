import Foundation

class FlightRequestTasksBuilderRemote: FlightRequestTasksBuilder {
    
    let environment: Environment
    let session: URLSession
    let pricingParser: PricingResponseParser
    
    init(environment: Environment,
         session: URLSession,
         pricingParser: PricingResponseParser) {
        self.environment = environment
        self.session = session
        self.pricingParser = pricingParser
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func buildRetrivingPollingSessionIdTask(origin: String,
                                            destination: String,
                                            outbound: Date,
                                            inbound: Date,
                                            completion: @escaping (Result<URL>) -> Void) -> URLSessionDataTask {
        let url = environment.apiBaseUrl.appendingPathComponent("pricing").appendingPathComponent("v1.0")
        
        var parameters = [String : String]()
        parameters["cabinclass"] = "Economy"
        parameters["country"] = "UK"
        parameters["currency"] = "GBP"
        parameters["locale"] = "en-GB"
        parameters["locationSchema"] = "iata"
        parameters["originplace"] = origin
        parameters["destinationplace"] = destination
        parameters["outbounddate"] = dateFormatter.string(from: outbound)
        parameters["inbounddate"] = dateFormatter.string(from: inbound)
        parameters["adults"] = "1"
        parameters["apiKey"] = environment.apiKey
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.set(headers: ["Content-Type" : "application/x-www-form-urlencoded"])
        request.httpBody = parameters.toHTTPParameters().data(using: .utf8)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let result: Result<URL>
            if let error = error {
                result = .failure(error)
            }
            else  if let httpURLResponse = response as? HTTPURLResponse,
                let string = httpURLResponse.allHeaderFields["Location"] as? String,
                let url = URL(string: string) {
                result = .success(url)
            }
            else {
                result = .failure(HTTPError.unknownError)
            }
            completion(result)
        }
        
        return task
    }
    
    func buildGetFlightsTask(sessionURL: URL,
                             completion: @escaping (Result<([Itinerarie], Bool)>) -> Void) -> URLSessionDataTask {
        
        var parameters = [String : String]()
        parameters["apiKey"] = environment.apiKey
        let requesstUrl = sessionURL.appending(getParameters: parameters)

        var request = URLRequest(url: requesstUrl)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let result: Result<([Itinerarie], Bool)>
            if let error = error {
                result = .failure(error)
            }
            else  if let data = data {
                do {
                    let itinerariesResult = try self.pricingParser.itinerariesFrom(data: data)
                    result = .success(itinerariesResult)
                }
                catch {
                    print(error)
                    result = .failure(error)
                }
            }
            else {
                result = .failure(HTTPError.unknownError)
            }
            completion(result)
        }
        return task
    }
    
}
