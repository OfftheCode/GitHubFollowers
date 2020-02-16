//
//  GFEncoder.swift
//  GHFollowersTests
//
//  Created by Piotr Szadkowski on 16/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation
@testable import GHFollowers

enum GFEncoder {
    
    static func enocde(user: User) -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        return try? encoder.encode(user)
    }
    
}
