//
//  FavoriteBeer.swift
//  Beer VIPER
//
//  Created by Adriano on 16/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteBeer: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var tagline: String = ""
    @objc dynamic var beerDescription: String = ""
    @objc dynamic var image_url: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
