//
//  GFDecoder.swift
//  GHFollowersTests
//
//  Created by Piotr Szadkowski on 17/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation

enum GFDecoder {
    
    static func decodeUser(from data: Data) throws -> User {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(User.self, from: data)
    }
    
    static func decodeFollowers(from data: Data) throws -> [Follower] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Follower].self, from: data)
    }
    
}
