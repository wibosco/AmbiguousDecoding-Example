//
//  ItemsTests.swift
//  AmbiguousDecoding-ExampleTests
//
//  Created by William Boles on 17/01/2023.
//  Copyright © 2023 Boles. All rights reserved.
//

import XCTest

@testable import AmbiguousDecoding_Example

final class ItemsTests: XCTestCase {
    var data: Data!
    
    // MARK: - Setup
    
    override func setUp() async throws {
        data = try Bundle(for: Self.self).loadJSONFromFile("ItemsResponse")
    }
    
    override func tearDown() async throws {
        data = nil
    }
    
    // MARK: - Tests
    
    // MARK: Decode
    
    func test_decode_count() throws {
        let content = try JSONDecoder().decode(Items.self, from: data)
        
        XCTAssertEqual(content.items.count, 3)
    }
    
    func test_decode_stringValue() throws {
        let content = try JSONDecoder().decode(Items.self, from: data)
        
        let item = content.items[0]
        
        XCTAssertEqual(item.name, "first")
        XCTAssertEqual(item.value, .string("value of first item"))
    }
    
    func test_decode_intValue() throws {
        let content = try JSONDecoder().decode(Items.self, from: data)
        
        let item = content.items[1]
        
        XCTAssertEqual(item.name, "second")
        XCTAssertEqual(item.value, .int(123))
    }
    
    func test_decode_stringArrayValue() throws {
        let content = try JSONDecoder().decode(Items.self, from: data)
        
        let item = content.items[2]
        
        XCTAssertEqual(item.name, "third")
        XCTAssertEqual(item.value, .stringArray(["a", "b", "c"]))
    }
}
