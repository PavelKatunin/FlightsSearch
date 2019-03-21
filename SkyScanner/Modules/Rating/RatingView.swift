import Foundation
import UIKit

class RatingView: UIView {
    
    let style: Style
    
    var rating: Float? {
        didSet {
            if let rating = rating {
                imageView.image = imageFor(rating: rating)
                label.text = String(format: "%.1f", rating)
                stack.isHidden = false
            }
            else {
                stack.isHidden = true
            }
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = style.titleFont
        label.textColor = style.titleColor
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
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
    
    func imageFor(rating: Float) -> UIImage? {
        if rating <= 2 {
            return UIImage(named: "ic_sentiment_very_dissatisfied_black_24px")
        }
        else if rating <= 4 {
            return UIImage(named: "ic_sentiment_dissatisfied_black_24px")
        }
        else if rating <= 6 {
            return UIImage(named: "ic_sentiment_neutral_black_24px")
        }
        else if rating <= 8 {
            return UIImage(named: "ic_sentiment_satisfied_black_24px")
        }
        else {
            return UIImage(named: "ic_sentiment_very_satisfied_black_24px")
        }
    }
    
    
}
