import Foundation
import UIKit

extension NSLayoutConstraint {
    
    func activate() {
        NSLayoutConstraint.activate([self])
    }
    
    func activated() -> NSLayoutConstraint {
        self.activate()
        return self
    }
    
    func with(constant: CGFloat) -> NSLayoutConstraint {
        self.constant = constant
        return self
    }
    
    func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
