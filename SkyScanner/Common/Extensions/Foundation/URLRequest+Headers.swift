import Foundation

extension URLRequest {
    
    mutating func set(headers: [String : String]) {
        headers.forEach { (arg) in
            let (key, value) = arg
            self.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}

