//
//  Person.swift
//  ChangingTypeCodable-Example
//
//  Created by William Boles on 17/01/2023.
//  Copyright © 2023 Boles. All rights reserved.
//

import Foundation

struct Person: Decodable {
    let name: String
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case city
        case country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        
        let city = try container.decode(String.self, forKey: .city)
        let country = try container.decode(String.self, forKey: .country)
        
        self.location = city + ", " + country
    }
}
