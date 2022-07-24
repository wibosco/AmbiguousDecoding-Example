//
//  ConcreteModel.swift
//  ChangingTypeCodable-Example
//
//  Created by William Boles on 24/07/2022.
//  Copyright © 2022 Boles. All rights reserved.
//

import Foundation

struct ConcreteModel: Codable, Equatable {
    let subModels: [ConcreteSubModel]
}

struct ConcreteSubModel: Codable, Equatable {
    let name: String
    let value: ConcreteValueType
    
    enum CodingKeys: String, CodingKey {
        case name
        case value
    }
    
    // MARK: - Init
    
    init(name: String, value: ConcreteValueType) {
        self.name = name
        self.value = value
    }
    
    // MARK: - Decoding

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)
        
        if name == "Code" {
            let code = try container.decode(Int.self, forKey: .value)
            value = .code(code)
        } else if name == "Access" {
            let access = try container.decode(Bool.self, forKey: .value)
            value = access ? .granted : .denied
        } else if name == "VerificationOptions" {
            let options = try container.decode([String].self, forKey: .value)
            value = .verificationOptions(options)
        } else if name == "UserDetails" {
            let user = try container.decode(User.self, forKey: .value)
            value = .userDetails(user)
        } else {
            fatalError("Unexpected type encountered")
        }
    }
    
    // MARK - Encode
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        
        switch value {
        case .code(let value):
            try container.encode(value, forKey: .value)
        case .granted:
            try container.encode(true, forKey: .value)
        case .denied:
            try container.encode(false, forKey: .value)
        case .verificationOptions(let value):
            try container.encode(value, forKey: .value)
        case .userDetails(let value):
            try container.encode(value, forKey: .value)
        }
    }
}

enum ConcreteValueType: Codable, Equatable {
    case code(_ value: Int)
    case granted
    case denied
    case verificationOptions(_ value: [String])
    case userDetails(_ value: User)
}
