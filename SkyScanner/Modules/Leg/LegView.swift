import UIKit

final class LegView: UIView, LegViewProtocol {
    
    var carrierImageData: Data? {
        didSet {
            if let data = carrierImageData {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    var rightTitleText: String? {
        didSet {
            rightTitleLabel.text = rightTitleText
        }
    }
    
    var rightDescriptionText: String? {
        didSet {
            rightDescriptionLabel.text = rightDescriptionText
        }
    }
    
	var presenter: LegViewPresenter!
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 60).activate()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = style.titleFont
        label.textColor = style.titleColor
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = style.descriptionFont
        label.textColor = style.descriptionColor
        return label
    }()
    
    lazy var rightTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = style.titleFont
        label.textColor = style.titleColor
        label.textAlignment = .right
        return label
    }()
    
    lazy var rightDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = style.descriptionFont
        label.textColor = style.descriptionColor
        label.textAlignment = .right
        return label
    }()
    
    lazy var centerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,
                                                   descriptionLabel])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()
    
    lazy var rightStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rightTitleLabel,
                                                   rightDescriptionLabel])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, centerStack, rightStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        return stack
    }()
    
    let style: Style
    
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
