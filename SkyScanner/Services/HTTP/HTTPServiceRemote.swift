import Foundation

class HTTPServiceRemote: HTTPService {
    
    //MARK: - Models
    lazy var session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 60.0
        let session = URLSession(configuration: sessionConfig)
        return session
    }()
    
    lazy var jsonHeaders = [ "application/json" : "Content-Type",
                             "application/json" : "Accept"]
    
    //MARK: - Public
    func get(url: URL,
             headers: [String : String]?,
             parameters: [String : String]?,
             completion: @escaping (Result<HTTPResponse>) -> Void) {
        var requesstUrl = url
        
        if let parameters = parameters {
            requesstUrl = url.appending(getParameters: parameters)
        }
        
        var request = URLRequest(url: requesstUrl)
        request.httpMethod = "GET"
        
        if let headers = headers {
            request.set(headers: headers)
        }
        
        session.dataTask(with: request) { (data, response, error) in
            let result = self.resultFrom(data: data,
                                         urlResponse: response,
                                         error: error)
            completion(result)
            }.resume()
    }
    
    func post(url: URL,
              headers: [String : String]?,
              body: Data?,
              completion: @escaping (Result<HTTPResponse>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        if let headers = headers {
            request.set(headers: headers)
        }
        
        request.httpBody = body
        
        session.dataTask(with: request) { (data, response, error) in
            let result = self.resultFrom(data: data,
                                         urlResponse: response,
                                         error: error)
            completion(result)
            }.resume()
    }
    
    func postJson(url: URL,
                  headers: [String : String]?,
                  body: Data?,
                  completion: @escaping (Result<HTTPResponse>) -> Void) {
        let jsonHeaders = headers?.merging(self.jsonHeaders,
                                           uniquingKeysWith: { (original, new) -> String in
                                            return original
        })
        post(url: url,
             headers: jsonHeaders,
             body: body) { (result) in
                completion(result)
        }
    }
    
    func downloadData(url: URL, completion: @escaping (Result<Data>) -> Void) {
        session.dataTask(with: url,
                         completionHandler: { (data, response, error) in
                            
                            let result: Result<Data>
                            if let error = error {
                                print(error)
                                result = .failure(error)
                            }
                            else if let data = data {
                                result = .success(data)
                            }
                            else {
                                result = .failure(HTTPError.unknownError)
                            }
                            
                            completion(result)
                            
        }).resume()
    }
    
    //MARK: - Private
    private func resultFrom(data: Data?, urlResponse: URLResponse?, error: Error?) -> Result<HTTPResponse> {
        let result: Result<HTTPResponse>
        if let data = data {
            if let httpURLResponse = urlResponse as? HTTPURLResponse {
                let httpResponse = HTTPResponse(data: data,
                                                urlResponse: httpURLResponse)
                result = .success(httpResponse)
            }
            else {
                result = .failure(HTTPError.unknownError)
            }
        }
        else if let error = error {
            result = .failure(error)
        }
        else {
            result = .failure(HTTPError.unknownError)
        }
        
        return result
    }
    
}
