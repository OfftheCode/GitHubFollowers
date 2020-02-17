//
//  Follower.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 05/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}

extension Follower {
    
    init(from user: User) {
        self.login = user.login
        self.avatarUrl = user.avatarUrl
    }
    
    static let mock = Follower(login: "Johnatan", avatarUrl: "www.google.com/images/me.png")
    
}
