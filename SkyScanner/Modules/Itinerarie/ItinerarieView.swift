import UIKit

final class ItinerarieView: UIView, ItinerarieViewProtocol {
    
    var outboundLeg: Leg? {
        didSet {
            outboundLegModule.input.leg = outboundLeg
        }
    }
    
    var inboundLeg: Leg? {
        didSet {
            inboundLegModule.input.leg = inboundLeg
        }
    }
    
    
    var tagsText: String? {
        didSet {
            priceView.tagsLabel.text = tagsText
        }
    }
    
    var rightBottomTitleText: String? {
        didSet {
            priceView.priceLabel.text = rightBottomTitleText
        }
    }
    
    var rightBottomDescriptionText: String? {
        didSet {
            priceView.bookingsNumberLabel.text = rightBottomDescriptionText
        }
    }
    
    var rating: Float? {
        didSet {
            priceView.ratingView.rating = rating
        }
    }

	var presenter: ItinerarieViewPresenter!
    
    let style: Style
    
    lazy var outboundLegModule: MVP<UIView, LegIO> = {
        let legModule = LegRouter.createModule()
        return legModule
    }()
    
    lazy var inboundLegModule: MVP<UIView, LegIO> = {
        let legModule = LegRouter.createModule()
        return legModule
    }()
    
    lazy var legsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [outboundLegModule.view, inboundLegModule.view])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [legsStack, priceView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var priceView: PriceView = {
        let priceView = PriceView(style: style, frame: .zero)
        priceView.translatesAutoresizingMaskIntoConstraints = false
        return priceView
    }()
    
    init(style: Style, frame: CGRect) {
        self.style = style
        super.init(frame: frame)
        addSubview(stack)
        stack.activateConstraintsToWrapSuperview(.required,
                                                 UIEdgeInsets(top: 22,
                                                              left: 15,
                                                              bottom: 22,
                                                              right: 15))
        stack.addArrangedSubview(priceView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ItinerarieView {

}
