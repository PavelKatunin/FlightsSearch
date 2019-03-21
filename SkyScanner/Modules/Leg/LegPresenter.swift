import UIKit

final class LegPresenter {

    fileprivate weak var view: LegViewProtocol!
    fileprivate let router: LegWireframeProtocol
    
    weak var output: LegOutput?
    
    private let http: HTTPService
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    let durationFormatter = HoursMinutesFormatter()
    
    var legModel: Leg? {
        didSet {
            if let model = legModel {
                let departure = dateFormatter.string(from: model.departureTime)
                let arrival = dateFormatter.string(from: model.arrivalTime)
                view.titleText = "\(departure) - \(arrival)"
                var trackString = "\(model.origin)-\(model.destination)"
                if let carrier = model.carrier {
                    trackString = trackString + ", \(carrier)"
                }
                view.descriptionText = trackString
                view.rightDescriptionText = durationFormatter.stringFrom(minutesNumber: model.duration)
                view.rightTitleText = model.isDirect ? "Direct" : "Transfers"
                if let imageURL = model.carrierImageURL {
                    http.downloadData(url: imageURL) { (result) in
                        switch result {
                        case .success(let data):
                            DispatchQueue.main.async {
                                self.view.carrierImageData = data
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            else {
                view.carrierImageData = nil
                view.titleText = nil
                view.descriptionText = nil
                view.rightDescriptionText = nil
                view.rightTitleText = nil
            }
        }
    }

    init(view: LegViewProtocol,
         router: LegWireframeProtocol,
         http: HTTPService) {
        self.view = view
        self.router = router
        self.http = http
    }
}

extension LegPresenter: LegViewPresenter {
    
}

extension LegPresenter: LegIO {
    
    var leg: Leg? {
        get {
            return legModel
        }
        set {
            legModel = newValue
        }
    }
    
}
