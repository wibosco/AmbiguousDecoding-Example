//
//  ReusableModelTests.swift
//  ChangingTypeCodable-ExampleTests
//
//  Created by William Boles on 23/07/2022.
//

import XCTest
@testable import ChangingTypeCodable_Example

class ReusableModelTests: XCTestCase {
    
    // MARK: - Tests
    
    // MARK: Decode
    
    func test_decode_intValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableIntValueType")
        let model = try JSONDecoder().decode(ReusableModel.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "Code")
        XCTAssertEqual(model.subModels[0].value, .int(12))
    }
    
    func test_decode_boolValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableBoolValueType")
        let model = try JSONDecoder().decode(ReusableModel.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "Access")
        XCTAssertEqual(model.subModels[0].value, .bool(false))
    }
    
    func test_decode_stringArrayValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableStringArrayValueType")
        let model = try JSONDecoder().decode(ReusableModel.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "VerificationOptions")
        XCTAssertEqual(model.subModels[0].value, .stringArray(["Email", "SMS"]))
    }
    
    func test_decode_customTypeValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableCustomTypeValueType")
        let model = try JSONDecoder().decode(ReusableModel.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "UserDetails")
        XCTAssertEqual(model.subModels[0].value, .user(User(firstName: "Joe", lastName: "Bloggs")))
    }
    
    func test_decode_multipleValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableMulitpleValueTypes")
        let model = try JSONDecoder().decode(ReusableModel.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 2)
        
        XCTAssertEqual(model.subModels[0].name, "Access")
        XCTAssertEqual(model.subModels[0].value, .bool(true))
        
        XCTAssertEqual(model.subModels[1].name, "Code")
        XCTAssertEqual(model.subModels[1].value, .int(456))
    }
    
    // MARK: Encode
    
    func test_encode_intValueType() throws {
        let subModel = ReusableSubModel(name: "Int name", value: .int(123))
        
        let model = ReusableModel(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Int name\",\"value\":123}]}")
    }
    
    func test_encode_boolValueType() throws {
        let subModel = ReusableSubModel(name: "Bool name", value: .bool(true))
        
        let model = ReusableModel(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Bool name\",\"value\":true}]}")
    }
    
    func test_encode_stringArrayValueType() throws {
        let subModel = ReusableSubModel(name: "String Array name", value: .stringArray(["AA", "BB"]))
        
        let model = ReusableModel(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"String Array name\",\"value\":[\"AA\",\"BB\"]}]}")
    }
    
    func test_encode_customTypeValueType() throws {
        let user = User(firstName: "Joe", lastName: "Bloggs")
        let subModel = ReusableSubModel(name: "Custom Type name", value: .user(user))
        
        let model = ReusableModel(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Custom Type name\",\"value\":{\"firstName\":\"Joe\",\"lastName\":\"Bloggs\"}}]}")
    }
    
    func test_encode_multipleValueTypes() throws {
        let intSubModel = ReusableSubModel(name: "Int name", value: .int(123))
        let boolSubModel = ReusableSubModel(name: "Bool name", value: .bool(false))
        
        let model = ReusableModel(subModels: [intSubModel, boolSubModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Int name\",\"value\":123},{\"name\":\"Bool name\",\"value\":false}]}")
    }
}
