//
//  Model.swift
//  ChangingTypeCodable-Example
//
//  Created by William Boles on 23/07/2022.
//

import Foundation

struct Model: Codable, Equatable {
    let subModels: [SubModel]
}

struct SubModel: Codable, Equatable {
    let name: String
    let value: ChangingType
}

enum ChangingType: Codable, Equatable {
    case int(_ value: Int)
    case string(_ value: String)
    case bool(_ value: Bool)
    case stringArray(_ value: [String])
    case person(_ value: Person)
    
    // MARK: - Decode
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode([String].self) {
            self = .stringArray(value)
        } else if let value = try? container.decode(Person.self) {
            self = .person(value)
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
        case .string(let value):
            try container.encode(value)
        case .bool(let value):
            try container.encode(value)
        case .stringArray(let value):
            try container.encode(value)
        case .person(let value):
            try container.encode(value)
        }
    }
}

struct Person: Codable, Equatable {
    let firstName: String
    let lastName: String
}
