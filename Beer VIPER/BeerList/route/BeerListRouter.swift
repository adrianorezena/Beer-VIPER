//
//  BeerListRouter.swift
//  Beer VIPER
//
//  Created by Adriano on 11/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation
import UIKit

class BeerListRouter: BeerListPresenterToRouterProtocol {
    
    weak var view: UIViewController?
    
    static func createModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "BeerListNavigationController")
        if let view = navController.childViewControllers.first as? BeerListTableViewController {
            let presenter: BeerListViewToPresenterProtocol & BeerListInteractorToPresenterProtocol = BeerListPresenter()
            let interactor: BeerListPresenterToInteractorProtocol = BeerListInteractor()
            let router: BeerListPresenterToRouterProtocol = BeerListRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return navController
        }
        
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "BeerList", bundle: .main)
    }
    
    func presentDetailsScreen(from view: BeerListPresenterToViewProtocol, beer: BeerModel) {
        guard let delegate = view.presenter as? BeerDetailsDelegate else {
            return
        }
        
        let detailsScreen = BeerDetailsRouter.createModule(with: delegate, beerName: beer.name, beerTagline: beer.tagline, beerDescription: beer.description, beerImageURL: beer.image_url)        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(detailsScreen, animated: true)
        }
    }
    
    func presentFavoritesScreen(from view: BeerListPresenterToViewProtocol) {
        guard let delegate = view.presenter as? FavoriteBeersDelegate else {
            return
        }
        
        let favoritesScreen = FavoriteBeersRouter.createModule(with: delegate)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(favoritesScreen, animated: true)
        }
    }
    
}
