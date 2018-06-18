//
//  PersistencyManager.swift
//  Beer VIPER
//
//  Created by Adriano on 16/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation
import RealmSwift

class PersistencyManager {
    
    static let shared = PersistencyManager()
    
    private init() {
    }
    
    func addToFavorites(_ beer: BeerModel) {
        let realm = try! Realm()
        realm.beginWrite()
        
        var favoriteBeer = realm.object(ofType: FavoriteBeer.self, forPrimaryKey: beer.id)
        
        if favoriteBeer == nil {
            favoriteBeer = FavoriteBeer()
            favoriteBeer!.id = beer.id
        }
        
        favoriteBeer!.name = beer.name
        favoriteBeer!.tagline = beer.tagline
        favoriteBeer!.beerDescription = beer.description
        favoriteBeer!.image_url = beer.image_url
        
        realm.add(favoriteBeer!)
        try! realm.commitWrite()
    }
    
    func getFavorites() -> [FavoriteBeer]? {
        let realm = try! Realm()
        let favoriteBeers = realm.objects(FavoriteBeer.self)
        return Array(favoriteBeers)
    }
    
    func deleteFavoriteBeer(favoriteBeer: FavoriteBeer) {
        let realm = try! Realm()
        let favoriteBeer = realm.objects(FavoriteBeer.self).filter("id == %@", favoriteBeer.id)
        
        try! realm.write {
            realm.delete(favoriteBeer)
        }
    }
    
}
