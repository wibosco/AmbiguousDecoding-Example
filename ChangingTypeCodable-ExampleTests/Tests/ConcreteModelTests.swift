//
//  ConcreteModelTests.swift
//  ChangingTypeCodable-ExampleTests
//
//  Created by William Boles on 24/07/2022.
//  Copyright © 2022 Boles. All rights reserved.
//

import XCTest
@testable import ChangingTypeCodable_Example


class ConcreteModelTests: XCTestCase {

    // MARK: - Tests
    
    // MARK: Decode
    
    func test_decode_codeValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableIntValueType")
        let model = try JSONDecoder().decode(ConcreteModel.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "Code")
        XCTAssertEqual(model.subModels[0].value, .code(12))
    }
    
    func test_decode_grantedValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableBoolValueType")
        let model = try JSONDecoder().decode(ConcreteModel.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "Access")
        XCTAssertEqual(model.subModels[0].value, .denied)
    }
    
    func test_decode_verificationOptionsValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableStringArrayValueType")
        let model = try JSONDecoder().decode(ConcreteModel.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "VerificationOptions")
        XCTAssertEqual(model.subModels[0].value, .verificationOptions(["Email", "SMS"]))
    }
    
    func test_decode_userDetailsValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableCustomTypeValueType")
        let model = try JSONDecoder().decode(ConcreteModel.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 1)
        
        XCTAssertEqual(model.subModels[0].name, "UserDetails")
        XCTAssertEqual(model.subModels[0].value, .userDetails(User(firstName: "Joe", lastName: "Bloggs")))
    }
    
    func test_decode_multipleValueType() throws {
        let data = try Bundle(for: Self.self).loadJSONFromFile("CodableMulitpleValueTypes")
        let model = try JSONDecoder().decode(ConcreteModel.self, from: data)
        
        XCTAssertEqual(model.subModels.count, 2)
        
        XCTAssertEqual(model.subModels[0].name, "Access")
        XCTAssertEqual(model.subModels[0].value, .granted)
        
        XCTAssertEqual(model.subModels[1].name, "Code")
        XCTAssertEqual(model.subModels[1].value, .code(456))
    }
    
    // MARK: Encode
    
    func test_encode_codeValueType() throws {
        let subModel = ConcreteSubModel(name: "Code", value: .code(456))
        
        let model = ConcreteModel(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Code\",\"value\":456}]}")
    }
    
    func test_encode_grantedValueType() throws {
        let subModel = ConcreteSubModel(name: "Access", value: .granted)
        
        let model = ConcreteModel(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Access\",\"value\":true}]}")
    }
    
    func test_encode_deniedValueType() throws {
        let subModel = ConcreteSubModel(name: "Access", value: .denied)
        
        let model = ConcreteModel(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Access\",\"value\":false}]}")
    }
    
    func test_encode_verificationOptionsValueType() throws {
        let subModel = ConcreteSubModel(name: "VerificationOptions", value: .verificationOptions(["Email", "SMS"]))
        
        let model = ConcreteModel(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"VerificationOptions\",\"value\":[\"Email\",\"SMS\"]}]}")
    }
    
    func test_encode_userDetailsValueType() throws {
        let user = User(firstName: "Joe", lastName: "Bloggs")
        let subModel = ConcreteSubModel(name: "UserDetails", value: .userDetails(user))
        
        let model = ConcreteModel(subModels: [subModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"UserDetails\",\"value\":{\"firstName\":\"Joe\",\"lastName\":\"Bloggs\"}}]}")
    }
    
    func test_encode_multipleValueTypes() throws {
        let codeSubModel = ConcreteSubModel(name: "Code", value: .code(456))
        let accessSubModel = ConcreteSubModel(name: "Access", value: .granted)
        
        let model = ConcreteModel(subModels: [codeSubModel, accessSubModel])
        
        let data = try JSONEncoder().encode(model)
        let encodedString = String(data: data, encoding: .utf8)!
        
        XCTAssertEqual(encodedString, "{\"subModels\":[{\"name\":\"Code\",\"value\":456},{\"name\":\"Access\",\"value\":true}]}")
    }
}
