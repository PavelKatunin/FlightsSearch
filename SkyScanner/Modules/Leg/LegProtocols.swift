import Foundation

// MARK: - Wireframe

protocol LegWireframeProtocol: class {

}

// MARK: - Presenter

protocol LegViewPresenter: class {
    
}

typealias LegPresenterProtocol = LegViewPresenter

// MARK: - View

protocol LegViewProtocol: class {
    
    var carrierImageData: Data? { set get }
    var titleText: String? { set get }
    var descriptionText: String? { set get }
    var rightTitleText: String? { set get }
    var rightDescriptionText: String? { set get }
    
}

// MARK: - IO

protocol LegInput: class {
    var leg: Leg? { get set }
}

protocol LegOutput: class {

}

protocol LegIO: LegInput {
    var output: LegOutput? { set get }
}
