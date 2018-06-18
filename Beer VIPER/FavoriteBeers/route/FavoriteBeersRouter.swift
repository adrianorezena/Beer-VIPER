//
//  FavoriteBeersRouter.swift
//  Beer VIPER
//
//  Created by Adriano on 17/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation
import UIKit

class FavoriteBeersRouter: FavoriteBeersPresenterToRouterProtocol {
    
    static func createModule(with delegate: FavoriteBeersDelegate) -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "FavoriteBeersTableViewController") as? FavoriteBeersPresenterToViewProtocol
        let presenter = FavoriteBeersPresenter()
        let interactor: FavoriteBeersPresenterToInteractorProtocol = FavoriteBeersInteractor()
        let router: FavoriteBeersPresenterToRouterProtocol = FavoriteBeersRouter()
        
        // Connecting
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return view as! FavoriteBeersTableViewController
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "FavoriteBeers", bundle: .main)
    }
    
    func presentDetailsScreen(from view: FavoriteBeersPresenterToViewProtocol, favoriteBeer: FavoriteBeer) {
        guard let delegate = view.presenter as? BeerDetailsDelegate else {
            return
        }
        
        let detailsScreen = BeerDetailsRouter.createModule(with: delegate, beerName: favoriteBeer.name, beerTagline: favoriteBeer.tagline, beerDescription: favoriteBeer.beerDescription, beerImageURL: favoriteBeer.image_url)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(detailsScreen, animated: true)
        }
    }
    
}
