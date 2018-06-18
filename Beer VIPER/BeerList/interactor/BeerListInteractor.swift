//
//  BeerListInteractor.swift
//  Beer VIPER
//
//  Created by Adriano on 11/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation

class BeerListInteractor: BeerListPresenterToInteractorProtocol {

    var presenter: BeerListInteractorToPresenterProtocol?
        
    func fetchBeers(_ page: Int?) {
        
        ServiceManager.shared.fetchBeers(page, onSuccess: { (beerModelArray) in
            self.presenter?.beersFetched(beers: beerModelArray)
        }) { (errorMessage) in
            self.presenter?.beersFetchedFailed(message: errorMessage)
        }
        
    }
    
    func filterBeers(_ searchString: String, _ beers: [BeerModel]) -> [BeerModel] {
        return beers.filter({ (beer: BeerModel) -> Bool in
            return (beer.name.lowercased().contains(searchString.lowercased())) || (beer.tagline.lowercased().contains(searchString.lowercased()))
        })
    }
    
    func addToFavorites(_ beer: BeerModel) {
        PersistencyManager.shared.addToFavorites(beer)
    }
    
}
