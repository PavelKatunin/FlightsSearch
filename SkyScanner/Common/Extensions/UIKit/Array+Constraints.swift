import Foundation
import UIKit

extension Array where Element == NSLayoutConstraint {
    
    func activate() {
        NSLayoutConstraint.activate(self)
    }
    
    func deactivate() {
        NSLayoutConstraint.deactivate(self)
    }
    
    func changeActive(_ active: Bool) {
        if active {
            self.activate()
        } else {
            self.deactivate()
        }
    }
    
    func activated() -> [Element] {
        self.activate()
        return self
    }
    
    func deactivated() -> [Element] {
        self.deactivate()
        return self
    }
}
