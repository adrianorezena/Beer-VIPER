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
        var urlString = "https://api.punkapi.com/v2/beers?per_page=25"
        
        if let page = page, page > 0 {
            urlString += "&page=\(page)"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                self.presenter?.beersFetchedFailed(message: error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            print(String(data: data, encoding: String.Encoding.utf8) as String?)
            
            do {
                let beerData = try JSONDecoder().decode([BeerModel].self, from: data)
                self.presenter?.beersFetched(beers: beerData)
            } catch {
                if let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                    self.presenter?.beersFetchedFailed(message: errorModel.message)
                } else {
                    self.presenter?.beersFetchedFailed(message: "Error when fetching beers")
                }
            }
            
            }.resume()
    }
    
    func filterBeers(_ searchString: String, _ beers: [BeerModel]) -> [BeerModel] {
        return beers.filter({ (beer: BeerModel) -> Bool in
            return (beer.name.lowercased().contains(searchString.lowercased())) || (beer.tagline.lowercased().contains(searchString.lowercased()))
        })
    }
    
}
