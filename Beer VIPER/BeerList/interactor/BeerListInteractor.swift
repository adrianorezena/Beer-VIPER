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
    
    func fetchBeers() {
        let urlString = "https://api.punkapi.com/v2/beers"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                self.presenter?.beersFetchedFailed()
            }
            
            guard let data = data else { return }
            
            do {
                let beerData = try JSONDecoder().decode([BeerListModel].self, from: data)
                self.presenter?.beersFetched(beers: beerData)
            } catch {
                self.presenter?.beersFetchedFailed()
            }
            
        }.resume()        
    }
    
}
