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
    
    func showBeers(beers: [BeerModel])
    func showError(message: String)
}

protocol BeerListInteractorToPresenterProtocol: class {
    func beersFetched(beers: [BeerModel])
    func beersFetchedFailed(message: String)
}

protocol BeerListPresenterToInteractorProtocol: class {
    var presenter: BeerListInteractorToPresenterProtocol? {get set}
    func fetchBeers(_ page: Int?)
    func filterBeers(_ searchString: String, _ beers: [BeerModel]) -> [BeerModel]
    func addToFavorites(_ beer: BeerModel)
}

protocol BeerListViewToPresenterProtocol: class {
    var view: BeerListPresenterToViewProtocol? {get set};
    var interactor: BeerListPresenterToInteractorProtocol? {get set};
    var router: BeerListPresenterToRouterProtocol? {get set}
    func updateView()
    func loadNextPage(page: Int)
    func showDetails(beer: BeerModel)
    func didTriggerSearchEvent(_ searchText: String, _ beers: [BeerModel])
    func addToFavorites(_ beer: BeerModel)
    func showFavorites()
}

protocol BeerListPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController    
    func presentDetailsScreen(from view: BeerListPresenterToViewProtocol, beer: BeerModel)
    func presentFavoritesScreen(from view: BeerListPresenterToViewProtocol)
}
