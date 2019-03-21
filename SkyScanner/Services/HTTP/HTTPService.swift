import Foundation

enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
}

enum HTTPError: Error {
    case unknownError
}

class HTTPResponse {
    var data: Data?
    var headers: [AnyHashable : Any]?
    
    init(data: Data?,
         headers: [String : String]?) {
        self.data = data
        self.headers = headers
    }
    
    init(data: Data?,
         urlResponse: HTTPURLResponse) {
        self.data = data
        self.headers = urlResponse.allHeaderFields
    }
}

protocol HTTPService {
    
    func postJson(url: URL,
                  headers: [String : String]?,
                  body: Data?,
                  completion: @escaping (Result<HTTPResponse>) -> Void)
    
    func post(url: URL,
              headers: [String : String]?,
              body: Data?,
              completion: @escaping (Result<HTTPResponse>) -> Void)
    
    func get(url: URL,
             headers: [String : String]?,
             parameters: [String : String]?,
             completion: @escaping (Result<HTTPResponse>) -> Void)
    
    func downloadData(url: URL, completion: @escaping (Result<Data>) -> Void)
    
}
