//
//  User.swift
//  ChangingTypeCodable-Example
//
//  Created by William Boles on 24/07/2022.
//  Copyright © 2022 Boles. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {
    let firstName: String
    let lastName: String
}
