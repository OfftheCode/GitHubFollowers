//
//  User.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 05/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}

extension User {
    static let mock = User(login: "Bar", avatarUrl: "https://avatars0.githubusercontent.com/u/24880265?s=40&v=4", name: "Foo Bar", location: "London", bio: "I live in the world full of mocks", publicRepos: 2, publicGists: 0, htmlUrl: "https://github.com/OfftheCode", following: 3, followers: 8, createdAt: Date.mockDate)
}
