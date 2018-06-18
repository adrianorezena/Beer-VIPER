//
//  FavoriteBeersPresenter.swift
//  Beer VIPER
//
//  Created by Adriano on 17/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation

class FavoriteBeersPresenter: FavoriteBeersViewToPresenterProtocol, FavoriteBeersInteractorToPresenterProtocol {
    
    var view: FavoriteBeersPresenterToViewProtocol?
    var interactor: FavoriteBeersPresenterToInteractorProtocol?
    var router: FavoriteBeersPresenterToRouterProtocol?
    var delegate: FavoriteBeersDelegate?
    var favoriteBeers: [FavoriteBeer]!
    
    func updateView() {
        interactor?.fetchFavoriteBeers()        
    }
    
    func showDetails(favoriteBeer: FavoriteBeer) {
        router?.presentDetailsScreen(from: view!, favoriteBeer: favoriteBeer)
    }
    
    func fetchFavoriteBeers(favoriteBeers: [FavoriteBeer]) {
        view?.showFavorites(favoriteBeers: favoriteBeers)
    }
    
    func removeFromFavorites(favoriteBeer: FavoriteBeer) {
        interactor?.removeFromFavorites(favoriteBeer: favoriteBeer)
    }
    
}


//MARK: - BeerDetailsDelegate
extension FavoriteBeersPresenter: BeerDetailsDelegate {
    
}
