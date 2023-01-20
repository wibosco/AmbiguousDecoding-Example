//
//  PersonTests.swift
//  AmbiguousDecoding-ExampleTests
//
//  Created by William Boles on 24/07/2022.
//  Copyright © 2022 Boles. All rights reserved.
//

import XCTest

@testable import AmbiguousDecoding_Example

final class PersonTests: XCTestCase {
    var data: Data!
    
    // MARK: - Setup
    
    override func setUp() async throws {
        data = try Bundle(for: Self.self).loadJSONFromFile("PersonResponse")
    }
    
    override func tearDown() async throws {
        data = nil
    }
    
    // MARK: - Tests
    
    // MARK: Decode
    
    func test_decode_person() throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let person = try decoder.decode(Person.self, from: data)
        
        XCTAssertEqual(person.name, "Susan")
        XCTAssertEqual(person.location, "Glasgow, Scotland")
    }
}
