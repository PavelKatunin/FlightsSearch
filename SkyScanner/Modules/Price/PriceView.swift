import Foundation
import UIKit

class PriceView: UIView {
    
    let style: Style
    
    lazy var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = style.headingFont
        label.textColor = style.titleColor
        label.textAlignment = .right
        return label
    }()
    
    lazy var ratingView: RatingView = {
        let rating = RatingView(style: style, frame: .zero)
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    lazy var tagsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = style.descriptionFont
        label.textColor = style.labelColor
        return label
    }()
    
    lazy var bookingsNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = style.descriptionFont
        label.textColor = style.descriptionColor
        label.textAlignment = .right
        return label
    }()
    
    lazy var priceStack: UIStackView = {
        let spaceView = UIView()
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        let stack = UIStackView(arrangedSubviews: [ratingView, spaceView, priceLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var tagsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tagsLabel, bookingsNumberLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceStack, tagsStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    init(style: Style, frame: CGRect) {
        self.style = style
        super.init(frame: frame)
        addSubview(stack)
        stack.activateConstraintsToWrapSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
