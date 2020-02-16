//
//  FollowerModelTests.swift
//  GHFollowersTests
//
//  Created by Piotr Szadkowski on 16/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import XCTest
@testable import GHFollowers

class FollowerModelTests: XCTestCase {

    var user: User!
    
    override func setUp() {
        user = User(login: "superLogin", avatarUrl: "www.epicimages/superlogin.png", name: nil, location: nil, bio: nil, publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: Date.mockDate)
    }

    override func tearDown() {
        user = nil
    }

    func testConvertionFromUser() {
        // When
        let follower = Follower(from: user)
        
        // Then
        XCTAssertEqual(follower.login, "superLogin")
        XCTAssertEqual(follower.avatarUrl, "www.epicimages/superlogin.png")
    }
    
}
