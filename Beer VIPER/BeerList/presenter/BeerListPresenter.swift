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
        interactor?.fetchBeers()
    }
    
    func showDetails(beer: BeerListModel) {
        router?.presentDetailsScreen(from: view!, beer: beer)
    }
    
    func showFavorites(from view: BeerListPresenterToViewProtocol) {
        router?.presentFavoritesScreen(from: view)
    }
    
}

extension BeerListPresenter: BeerListInteractorToPresenterProtocol {
    
    func beersFetched(beers: [BeerListModel]) {
        view?.showBeers(beers: beers)
    }
    
    func beersFetchedFailed() {
        view?.showError()
    }
    
}


extension BeerListPresenter: BeerDetaileDelegate {
    
}
