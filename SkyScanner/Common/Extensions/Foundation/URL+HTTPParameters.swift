import Foundation

extension URL {
    
    func appending(getParameters: [String : String]) -> URL {
        return URL(string: self.absoluteString + "?" + getParameters.toHTTPParameters())!
    }
    
}
