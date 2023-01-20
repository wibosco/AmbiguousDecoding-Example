//
//  Items.swift
//  AmbiguousDecoding-Example
//
//  Created by William Boles on 17/01/2023.
//  Copyright © 2023 Boles. All rights reserved.
//

import Foundation

struct Items: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let name: String
    let value: ValueType
}

enum ValueType: Decodable, Equatable {
    case int(Int)
    case string(String)
    case stringArray([String])
    
    // MARK: - Decode
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([String].self) {
            self = .stringArray(value)
        } else {
            fatalError("Unexpected type encountered")
        }
    }
}
