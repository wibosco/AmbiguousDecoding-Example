//
//  ModelTests.swift
//  ChangingTypeCodable-ExampleTests
//
//  Created by William Boles on 23/07/2022.
//

import XCTest
@testable import ChangingTypeCodable_Example

class ModelTests: XCTestCase {
    
    // MARK: - Tests
    
    // MARK: Decode

    func test_decode_stringValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableStringValueType")
        let model = try JSONDecoder().decode(Model.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "String name")
        XCTAssertEqual(model.subModels[0].value, .string("String value"))
    }
    
    func test_decode_intValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableIntValueType")
        let model = try JSONDecoder().decode(Model.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "Int name")
        XCTAssertEqual(model.subModels[0].value, .int(12))
    }
    
    func test_decode_boolValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableBoolValueType")
        let model = try JSONDecoder().decode(Model.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "Bool name")
        XCTAssertEqual(model.subModels[0].value, .bool(false))
    }
    
    func test_decode_stringArrayValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableStringArrayValueType")
        let model = try JSONDecoder().decode(Model.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "String Array name")
        XCTAssertEqual(model.subModels[0].value, .stringArray(["AA", "BB"]))
    }
    
    func test_decode_stringCustomTypeValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableCustomTypeValueType")
        let model = try JSONDecoder().decode(Model.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "Custom Type name")
        XCTAssertEqual(model.subModels[0].value, .person(Person(firstName: "Joe", lastName: "Bloggs")))
    }
    
    func test_decode_multipleValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableMulitpleValueTypes")
        let model = try JSONDecoder().decode(Model.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 2)
        
        XCTAssertEqual(model.subModels[0].name, "Int name")
        XCTAssertEqual(model.subModels[0].value, .int(123))
        
        XCTAssertEqual(model.subModels[1].name, "Another Int name")
        XCTAssertEqual(model.subModels[1].value, .int(456))
    }
    
    // MARK: Encode
    
    func test_encode_stringValueType() throws {
        let subModel = SubModel(name: "String name", value: .string("a string"))
        
        let model = Model(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"String name\",\"value\":\"a string\"}]}")
    }
    
    func test_encode_intValueType() throws {
        let subModel = SubModel(name: "Int name", value: .int(123))
        
        let model = Model(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Int name\",\"value\":123}]}")
    }
    
    func test_encode_boolValueType() throws {
        let subModel = SubModel(name: "Bool name", value: .bool(true))
        
        let model = Model(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Bool name\",\"value\":true}]}")
    }
    
    func test_encode_stringArrayValueType() throws {
        let subModel = SubModel(name: "String Array name", value: .stringArray(["AA", "BB"]))
        
        let model = Model(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"String Array name\",\"value\":[\"AA\",\"BB\"]}]}")
    }
    
    func test_encode_stringCustomTypeValueType() throws {
        let subModel = SubModel(name: "Custom Type name", value: .person(Person(firstName: "Joe", lastName: "Bloggs")))
        
        let model = Model(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Custom Type name\",\"value\":{\"firstName\":\"Joe\",\"lastName\":\"Bloggs\"}}]}")
    }
    
    func test_encode_multipleValueTypes() throws {
        let subModelA = SubModel(name: "Int name", value: .int(123))
        let subModelB = SubModel(name: "Another Int name", value: .int(456))
        
        let model = Model(subModels: [subModelA, subModelB])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Int name\",\"value\":123},{\"name\":\"Another Int name\",\"value\":456}]}")
    }
}
