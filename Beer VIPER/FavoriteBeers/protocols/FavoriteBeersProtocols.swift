//
//  FavoriteBeersProtocols.swift
//  Beer VIPER
//
//  Created by Adriano on 17/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteBeersDelegate: class {
}

protocol FavoriteBeersPresenterToViewProtocol: class {
    var presenter: FavoriteBeersViewToPresenterProtocol? { get set }
    func showFavorites(favoriteBeers: [FavoriteBeer])
}

protocol FavoriteBeersViewToPresenterProtocol: class {
    var view: FavoriteBeersPresenterToViewProtocol? {get set}
    var interactor: FavoriteBeersPresenterToInteractorProtocol? {get set}
    var router: FavoriteBeersPresenterToRouterProtocol? {get set}
    var delegate: FavoriteBeersDelegate? { get set }
    
    func removeFromFavorites(favoriteBeer: FavoriteBeer)
    func showDetails(favoriteBeer: FavoriteBeer)
    func updateView()
}

protocol FavoriteBeersPresenterToInteractorProtocol: class {
    var presenter: FavoriteBeersInteractorToPresenterProtocol? {get set}
    
    func fetchFavoriteBeers()
    func removeFromFavorites(favoriteBeer: FavoriteBeer)
}

protocol FavoriteBeersInteractorToPresenterProtocol: class {
    func fetchFavoriteBeers(favoriteBeers: [FavoriteBeer])
}

protocol FavoriteBeersPresenterToRouterProtocol: class {

    static func createModule(with delegate: FavoriteBeersDelegate) -> UIViewController
    
    func presentDetailsScreen(from view: FavoriteBeersPresenterToViewProtocol, favoriteBeer: FavoriteBeer)

}
