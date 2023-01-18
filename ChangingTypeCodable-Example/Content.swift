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
    case book(Book)
    case movie(Movie)
    case televisionSeries(TelevisionSeries)
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
    }
    
    // MARK: - Init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .mediaType)
        
        switch type {
        case "book":
            let book = try Book(from: decoder)
            self = .book(book)
        case "movie":
            let movie = try Movie(from: decoder)
            self = .movie(movie)
        case "television_series":
            let televisionSeries = try TelevisionSeries(from: decoder)
            self = .televisionSeries(televisionSeries)
        default:
            fatalError("Unexpected media type encountered")
        }
    }
}

struct Book: Decodable, Equatable {
    let id: Int
    let title: String
    let author: String
    let publishedYear: Int
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case publishedYear = "published_year"
        case url
    }
}

struct Movie: Decodable, Equatable {
    let id: Int
    let title: String
    let director: String
    let url: URL
}

struct TelevisionSeries: Decodable, Equatable {
    let id: Int
    let title: String
    let totalSeasons: Int
    let totalEpisodes: Int
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case totalSeasons = "total_seasons"
        case totalEpisodes = "total_episodes"
        case url
    }
}
