//
//  BeerListPresenter.swift
//  Beer VIPER
//
//  Created by Adriano on 11/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation
import UIKit

class BeerListPresenter: BeerListViewToPresenterProtocol {
    
    weak var view: BeerListPresenterToViewProtocol?
    var interactor: BeerListPresenterToInteractorProtocol?
    var router: BeerListPresenterToRouterProtocol?
    
    func updateView() {
        interactor?.fetchBeers(nil)
    }
    
    func showDetails(beer: BeerModel) {
        router?.presentDetailsScreen(from: view!, beer: beer)
    }
    
    func loadNextPage(page: Int) {
        interactor?.fetchBeers(page)
    }
    
    func didTriggerSearchEvent(_ searchText: String, _ beers: [BeerModel]) {
        var filteredBeers = beers
        if (!searchText.isEmpty) {
            filteredBeers = (interactor?.filterBeers(searchText, beers))!
        }
        
        view?.showBeers(beers: filteredBeers)
    }
    
    func addToFavorites(_ beer: BeerModel) {
        interactor?.addToFavorites(beer)
    }
    
    func showFavorites() {
        router?.presentFavoritesScreen(from: view!)
    }
    
}


//MARK: - BeerListInteractorToPresenterProtocol
extension BeerListPresenter: BeerListInteractorToPresenterProtocol {
    
    func beersFetched(beers: [BeerModel]) {
        view?.showBeers(beers: beers)
    }
    
    func beersFetchedFailed(message: String) {
        view?.showError(message: message)
    }
    
}


//MARK: - BeerDetailsDelegate
extension BeerListPresenter: BeerDetailsDelegate {
    
}


//MARK: - FavoriteBeersDelegate
extension BeerListPresenter: FavoriteBeersDelegate {
    
}
