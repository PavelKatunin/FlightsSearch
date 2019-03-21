import UIKit

extension UIView {
    
    func constraintsToWrap(_ view: UIView,
                           _ priority: UILayoutPriority = .required,
                           _ insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        let attributes = [NSLayoutConstraint.Attribute.left,
                          NSLayoutConstraint.Attribute.right,
                          NSLayoutConstraint.Attribute.bottom,
                          NSLayoutConstraint.Attribute.top]
        
        constraints = attributes.map { (attribute) -> NSLayoutConstraint in
            
            var constant: CGFloat = 0
            
            if attribute == .left {
                constant = insets.left
            }
            else if attribute == .right {
                constant = -insets.right
            }
            else if attribute == .top {
                constant = insets.top
            }
            else if attribute == .bottom {
                constant = -insets.bottom
            }
            
            let constraint = NSLayoutConstraint(item: self,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: constant)
            
            constraint.priority = priority
            
            return constraint
        }

        return constraints
    }
    
    func activateConstraintsToWrapSuperview( _ priority: UILayoutPriority = .required,
                                             _ insets: UIEdgeInsets = .zero) {
        let constraints = constraintsToWrap(superview!, priority, insets)
        NSLayoutConstraint.activate(constraints)
    }

}
