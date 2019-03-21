import Foundation
import UIKit

extension UIView {

    @discardableResult
    func addShadow(drectionY: Int) -> UIView {
        layer.shadowColor = UIColor(white: 0, alpha: 0.20).cgColor
        layer.shadowOffset = CGSize(width: 0, height: drectionY)
        layer.shadowRadius = 8
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        return self
    }
}
