//
//  Bundle+Load.swift
//  AmbiguousDecoding-ExampleTests
//
//  Created by William Boles on 23/07/2022.
//

import Foundation

extension Bundle {
    func loadJSONFromFile(_ filename: String) throws -> Data {
        let url = url(forResource: filename, withExtension: "json")!
        return try Data(contentsOf: url)
    }
}
