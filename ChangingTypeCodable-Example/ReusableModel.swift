//
//  Model.swift
//  ChangingTypeCodable-Example
//
//  Created by William Boles on 23/07/2022.
//

import Foundation

struct ReusableModel: Codable, Equatable {
    let subModels: [ReusableSubModel]
}

struct ReusableSubModel: Codable, Equatable {
    let name: String
    let value: ReusableValueType
}

enum ReusableValueType: Codable, Equatable {
    case int(_ value: Int)
    case bool(_ value: Bool)
    case stringArray(_ value: [String])
    case user(_ value: User)
    
    // MARK: - Decode
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode([String].self) {
            self = .stringArray(value)
        } else if let value = try? container.decode(User.self) {
            self = .user(value)
        } else {
            fatalError("Unknown type encountered")
        }
    }
    
    // MARK: - Encode
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .int(let value):
            try container.encode(value)
        case .bool(let value):
            try container.encode(value)
        case .stringArray(let value):
            try container.encode(value)
        case .user(let value):
            try container.encode(value)
        }
    }
}
