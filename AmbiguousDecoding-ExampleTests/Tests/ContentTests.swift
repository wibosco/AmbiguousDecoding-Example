//
//  ContentTests.swift
//  AmbiguousDecoding-ExampleTests
//
//  Created by William Boles on 24/07/2022.
//  Copyright © 2022 Boles. All rights reserved.
//

import XCTest

@testable import AmbiguousDecoding_Example

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
        
        XCTAssertEqual(content.media.count, 2)
    }
    
    func test_decode_text() throws {
        let content = try JSONDecoder().decode(Content.self, from: data)
        
        let text = Text(id: 12,
                        text: "This is an example of text media")
        
        XCTAssertEqual(content.media[0], .text(text))
    }
    
    func test_decode_image() throws {
        let content = try JSONDecoder().decode(Content.self, from: data)
        
        let image = Image(id: 2785,
                          caption: "An example caption associated with image media",
                          url: URL(string: "https://example.com/images/2785.jpg")!)
        
        XCTAssertEqual(content.media[1], .image(image))
    }
}
