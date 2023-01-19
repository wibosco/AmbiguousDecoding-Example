//
//  Content.swift
//  ChangingTypeCodable-Example
//
//  Created by William Boles on 15/01/2023.
//  Copyright © 2023 Boles. All rights reserved.
//

import Foundation

struct Content: Decodable {
    let media: [Media]
}

enum Media: Decodable, Equatable {
    case text(Text)
    case image(Image)
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
    }
    
    // MARK: - Init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .mediaType)
        
        switch type {
        case "text":
            let text = try Text(from: decoder)
            self = .text(text)
        case "image":
            let image = try Image(from: decoder)
            self = .image(image)
        default:
            fatalError("Unexpected media type encountered")
        }
    }
}

struct Text: Decodable, Equatable {
    let id: Int
    let text: String
}

struct Image: Decodable, Equatable {
    let id: Int
    let caption: String
    let url: URL
}
