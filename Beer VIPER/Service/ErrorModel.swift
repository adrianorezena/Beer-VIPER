//
//  ErrorModel.swift
//  Beer VIPER
//
//  Created by Adriano on 16/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import Foundation

class ErrorModel: Decodable {
    let statusCode: Int
    let error: String
    let message: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusCode = try container.decode(Int.self, forKey: .statusCode)
        self.error = try container.decode(String.self, forKey: .error)
        self.message = try container.decode(String.self, forKey: .message)
    }
    
    private enum CodingKeys : String, CodingKey {
        case statusCode
        case error
        case message
    }
    
}
