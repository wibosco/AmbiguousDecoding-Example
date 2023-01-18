//
//  ContentTests.swift
//  ChangingTypeCodable-ExampleTests
//
//  Created by William Boles on 24/07/2022.
//  Copyright © 2022 Boles. All rights reserved.
//

import XCTest

@testable import ChangingTypeCodable_Example

final class ContentTests: XCTestCase {
    var data: Data!
    
    // MARK: - Setup
    
    override func setUp() async throws {
        data = try Bundle(for: Self.self).loadJSONFromFile("ContentResponse")
    }
    
    override func tearDown() async throws {
        data = nil
    }
    
    // MARK: - Tests
    
    // MARK: Decode
    
    func test_decode_mediaArray() throws {
        let content = try JSONDecoder().decode(Content.self, from: data)
        
        XCTAssertEqual(content.media.count, 3)
    }
    
    func test_decode_book() throws {
        let content = try JSONDecoder().decode(Content.self, from: data)
        
        let book = Book(id: 12,
                        title: "The Hobbit",
                        author: "J. R. R. Tolkien",
                        publishedYear: 1937,
                        url: URL(string: "https://en.wikipedia.org/wiki/The_Hobbit")!)
        
        XCTAssertEqual(content.media[0], .book(book))
    }
    
    func test_decode_movie() throws {
        let content = try JSONDecoder().decode(Content.self, from: data)
        
        let movie = Movie(id: 2785,
                          title: "The Lord of the Rings: The Fellowship of the Ring",
                          director: "Peter Jackson",
                          url: URL(string: "https://en.wikipedia.org/wiki/The_Lord_of_the_Rings:_The_Fellowship_of_the_Ring")!)
        
        XCTAssertEqual(content.media[1], .movie(movie))
    }
    
    func test_decode_televisionSeries() throws {
        let content = try JSONDecoder().decode(Content.self, from: data)
        
        let televsionSeries = TelevisionSeries(id: 29890,
                                               title: "The Lord of the Rings: The Rings of Power",
                                               totalSeasons: 1,
                                               totalEpisodes: 8,
                                               url: URL(string: "https://en.wikipedia.org/wiki/The_Lord_of_the_Rings:_The_Rings_of_Power")!)
        
        XCTAssertEqual(content.media[2], .televisionSeries(televsionSeries))
    }
}
