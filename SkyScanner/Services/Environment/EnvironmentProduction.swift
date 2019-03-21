import Foundation

class EnvironmentProduction: Environment {
    
    var apiKey: String {
        return "ss630745725358065467897349852985"
    }
    
    var apiBaseUrl: URL {
        return URL(string: "http://partners.api.skyscanner.net/apiservices")!
    }
    
}
