//
//  BeerDetailProtocols.swift
//  Beer VIPER
//
//  Created by Adriano on 12/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation
import UIKit

protocol BeerDetailsDelegate: class {
}

protocol BeerDetailsInteractorToPresenterProtocol: class {
}

protocol BeerDetailsPresenterToInteractorProtocol: class {
    var presenter: BeerDetailsInteractorToPresenterProtocol? {get set}
}

protocol BeerDetailsPresenterToViewProtocol: class {
    var presenter: BeerDetailsViewToPresenterProtocol? { get set }
    
    func showBeerDetails(beerName: String, beerTagline: String, beerDescription: String, beerImageURL: String)
}

protocol BeerDetailsViewToPresenterProtocol: class {
    var view: BeerDetailsPresenterToViewProtocol? {get set}
    var interactor: BeerDetailsPresenterToInteractorProtocol? {get set}
    var router: BeerDetailsPresenterToRouterProtocol? {get set}
    var delegate: BeerDetailsDelegate? { get set }
    
    func updateView()
}

protocol BeerDetailsPresenterToRouterProtocol: class {
    static func createModule(with delegate: BeerDetailsDelegate, beerName: String, beerTagline: String, beerDescription: String, beerImageURL: String) -> UIViewController
}
