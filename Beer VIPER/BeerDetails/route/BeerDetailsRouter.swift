//
//  BeerDetailsRouter.swift
//  Beer VIPER
//
//  Created by Adriano on 12/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation
import UIKit

class BeerDetailsRouter: BeerDetailsPresenterToRouterProtocol {
    
    static func createModule(with delegate: BeerDetaileDelegate, beer: BeerModel) -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "BeerDetailsViewController") as? BeerDetailsPresenterToViewProtocol
        //let presenter: BeerDetailsViewToPresenterProtocol & BeerDetailsInteractorToPresenterProtocol = BeerDetailPresenter()
        let presenter = BeerDetailPresenter()
        let interactor: BeerDetailsPresenterToInteractorProtocol = BeerDetailInteractor()
        let router: BeerDetailsPresenterToRouterProtocol = BeerDetailsRouter()
        
        // Connecting
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        presenter.beer = beer
        interactor.presenter = presenter
        
        return view as! BeerDetailsViewController
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "BeerDetails", bundle: .main)
    }
    
}
