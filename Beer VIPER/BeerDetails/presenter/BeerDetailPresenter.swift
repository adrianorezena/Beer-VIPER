//
//  BeerDetailPresenter.swift
//  Beer VIPER
//
//  Created by Adriano on 12/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation

class BeerDetailPresenter: BeerDetailsViewToPresenterProtocol, BeerDetailsInteractorToPresenterProtocol {
    
    var view: BeerDetailsPresenterToViewProtocol?
    var interactor: BeerDetailsPresenterToInteractorProtocol?
    var router: BeerDetailsPresenterToRouterProtocol?
    var delegate: BeerDetaileDelegate?
    
    var beer: BeerModel!
    
    func updateView() {
        view?.showBeerDetails(beer: beer)
    }

}
