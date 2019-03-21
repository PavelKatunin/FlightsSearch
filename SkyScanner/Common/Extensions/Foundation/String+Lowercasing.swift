import Foundation

extension String {
    
    func lowercasingFirstLetter() -> String {
        return prefix(1).lowercased() + self.dropFirst()
    }
    
    mutating func lowercaseFirstLetter() {
        self = self.lowercasingFirstLetter()
    }
}
