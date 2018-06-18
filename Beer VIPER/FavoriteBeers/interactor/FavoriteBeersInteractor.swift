//
//  FavoriteBeersInteractor.swift
//  Beer VIPER
//
//  Created by Adriano on 17/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation

class FavoriteBeersInteractor: FavoriteBeersPresenterToInteractorProtocol {
    var presenter: FavoriteBeersInteractorToPresenterProtocol?
    
    func fetchFavoriteBeers() {
        if let favoriteBeers = PersistencyManager.shared.getFavorites() {
            presenter?.fetchFavoriteBeers(favoriteBeers: favoriteBeers)
        }
    }
    
    func removeFromFavorites(favoriteBeer: FavoriteBeer) {
        PersistencyManager.shared.deleteFavoriteBeer(favoriteBeer: favoriteBeer)
        fetchFavoriteBeers()
    }
    
}
