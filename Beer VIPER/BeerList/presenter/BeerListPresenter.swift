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
    //var beers: [BeerModel]!
    //var beers: [BeerModel] = []
    
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
        //view.configureWithItems(items: buildItems(cities!))
    }
    
    func showFavorites(from view: BeerListPresenterToViewProtocol) {
        router?.presentFavoritesScreen(from: view)
    }
    
}

extension BeerListPresenter: BeerListInteractorToPresenterProtocol {
    
    func beersFetched(beers: [BeerModel]) {
        view?.showBeers(beers: beers)
    }
    
    func beersFetchedFailed() {
        view?.showError()
    }
    
}


extension BeerListPresenter: BeerDetaileDelegate {
    
}
