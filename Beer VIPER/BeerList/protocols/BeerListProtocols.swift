//
//  BeerListProtocols.swift
//  Beer VIPER
//
//  Created by Adriano on 11/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation
import UIKit


protocol BeerListPresenterToViewProtocol: class {
    var presenter: BeerListViewToPresenterProtocol? { get set }
    
    func showBeers(beers: [BeerListModel])
    func showError()
}

protocol BeerListInteractorToPresenterProtocol: class {
    func beersFetched(beers: [BeerListModel])
    func beersFetchedFailed()
}

protocol BeerListPresenterToInteractorProtocol: class {
    var presenter: BeerListInteractorToPresenterProtocol? {get set}
    func fetchBeers()
}

protocol BeerListViewToPresenterProtocol: class {
    var view: BeerListPresenterToViewProtocol? {get set};
    var interactor: BeerListPresenterToInteractorProtocol? {get set};
    var router: BeerListPresenterToRouterProtocol? {get set}
    func updateView()
    func showDetails(beer: BeerListModel)
}

protocol BeerListPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController    
    func presentDetailsScreen(from view: BeerListPresenterToViewProtocol, beer: BeerListModel)
    func presentFavoritesScreen(from view: BeerListPresenterToViewProtocol)
}
