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
    var image: Image!
    var text: Text!
    var content: Content!
    
    // MARK: - Setup
    
    override func setUp() async throws {
        data = try Bundle(for: Self.self).loadJSONFromFile("ContentResponse")
        
        image = Image(id: 2785,
                      caption: "This is an example of image media",
                      url: URL(string: "https://example.com/images/2785.jpg")!)
        
        text = Text(id: 12,
                    text: "This is an example of text media")
        
        content = Content(media: [.text(text), .image(image)])
    }
    
    override func tearDown() async throws {
        data = nil
        image = nil
        text = nil
        content = nil
    }
    
    // MARK: - Tests
    
    // MARK: Decode
    
    func test_decode_content() throws {
        let decoded = try JSONDecoder().decode(Content.self, from: data)
        
        XCTAssertEqual(decoded, content)
    }
    
    // MARK: Encode
    
    func test_encode_content() throws {
        let encoded = try JSONEncoder().encode(content)
        let decoded = try JSONDecoder().decode(Content.self, from: encoded)
        
        XCTAssertEqual(decoded, content)
    }
}
