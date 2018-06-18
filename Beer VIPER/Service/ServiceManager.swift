//
//  ServiceManager.swift
//  Beer VIPER
//
//  Created by Adriano on 16/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation

class ServiceManager {
    
    static let shared = ServiceManager()
    
    private init() {
    }
    
    func fetchBeers(_ page: Int?, onSuccess: @escaping ([BeerModel]) -> Void, onError: @escaping (String) -> Void) {
        var urlString = "https://api.punkapi.com/v2/beers?per_page=25"
        
        if let page = page, page > 0 {
            urlString += "&page=\(page)"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                onError(error!.localizedDescription)
            }
            
            guard let data = data else { return }                        
            
            do {
                let beerData = try JSONDecoder().decode([BeerModel].self, from: data)
                onSuccess(beerData)
            } catch {
                if let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                    onError(errorModel.message)
                } else {
                    onError("Error when fetching beers")
                }
            }            
        }.resume()
    }
    
}
