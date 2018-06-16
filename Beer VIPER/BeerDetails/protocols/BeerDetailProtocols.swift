//
//  BeerDetailProtocols.swift
//  Beer VIPER
//
//  Created by Adriano on 12/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation
import UIKit

protocol BeerDetaileDelegate: class {
    //func didAddContact(_ contact: Contact)
    //func didCancelAddContact()    
}



protocol BeerDetailsInteractorToPresenterProtocol: class {
//    func beersFetched(beers: [BeerListModel])
//    func beersFetchedFailed()
}

protocol BeerDetailsPresenterToInteractorProtocol: class {
    var presenter: BeerDetailsInteractorToPresenterProtocol? {get set}
}

protocol BeerDetailsPresenterToViewProtocol: class {
    var presenter: BeerDetailsViewToPresenterProtocol? { get set }
    func showBeerDetails(beer: BeerModel)
}

protocol BeerDetailsViewToPresenterProtocol: class {
    var view: BeerDetailsPresenterToViewProtocol? {get set}
    var interactor: BeerDetailsPresenterToInteractorProtocol? {get set}
    var router: BeerDetailsPresenterToRouterProtocol? {get set}
    var delegate: BeerDetaileDelegate? { get set }
    
    func updateView()
}





protocol BeerDetailsPresenterToRouterProtocol: class {
    static func createModule(with delegate: BeerDetaileDelegate, beer: BeerModel) -> UIViewController
}
