//
//  BeerListModel.swift
//  Beer VIPER
//
//  Created by Adriano on 11/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation

class BeerModel: Decodable {
    let id: Int
    let name: String
    let tagline: String
    let description: String
    let image_url: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)        
        self.tagline = try container.decode(String.self, forKey: .tagline)
        self.description = try container.decode(String.self, forKey: .description)
        self.image_url = try container.decode(String.self, forKey: .image_url)
    }
    
    private enum CodingKeys : String, CodingKey {
        case id
        case name
        case tagline
        case description
        case image_url
    }
}
