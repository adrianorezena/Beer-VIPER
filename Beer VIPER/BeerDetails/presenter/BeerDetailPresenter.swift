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
    var delegate: BeerDetailsDelegate?
        
    var beerID: Int!
    var beerName: String!
    var beerTagline: String!
    var beerDescription: String!
    var beerImageURL: String!
    
    func updateView() {
        view?.showBeerDetails(beerName: beerName, beerTagline: beerTagline, beerDescription: beerDescription, beerImageURL: beerImageURL)
    }

}
