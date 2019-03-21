//
//  SearchFlightsProtocols.swift
//  SkyScanner
//
//  Created Pavel Katunin on 1/1/19.
//  Copyright © 2019 PavelKatunin. All rights reserved.
//
//

import Foundation

// MARK: - Wireframe

protocol SearchFlightsWireframeProtocol: class {

}

// MARK: - Presenter

protocol SearchFlightsViewPresenter: class {
    func viewLoaded()
}

typealias SearchFlightsPresenterProtocol = SearchFlightsViewPresenter

// MARK: - View

protocol SearchFlightsViewProtocol: class {
    var title: String? { set get }
}

// MARK: - IO

protocol SearchFlightsInput: class {
    
}

protocol SearchFlightsOutput: class {
    
}

protocol SearchFlightsIO: SearchFlightsInput {
    var output: SearchFlightsOutput? { set get }
}
