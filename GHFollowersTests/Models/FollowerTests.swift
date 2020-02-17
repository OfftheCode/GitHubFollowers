//
//  FollowerTests.swift
//  GHFollowersTests
//
//  Created by Piotr Szadkowski on 16/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import XCTest
@testable import GHFollowers

class FollowerTests: XCTestCase {

    var followers: [Follower]!
    
    override func setUp() {
        followers = [.mock, .mock, .mock]
    }

    override func tearDown() {
        followers.removeAll()
    }

    func testConvertionFromUser() {
        // When
        let user = User(login: "superLogin", avatarUrl: "www.epicimages/superlogin.png", name: nil, location: nil, bio: nil, publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: .mockDate)
        let follower = Follower(from: user)
        
        // Then
        XCTAssertEqual(follower.login, "superLogin")
        XCTAssertEqual(follower.avatarUrl, "www.epicimages/superlogin.png")
    }
    
    func testCodableConformance() throws {
        // Given
        let encodedFollowers = try GFEncoder.enocde(followers: followers)
        
        // When
        let decodedFollowers = try GFDecoder.decodeFollowers(from: encodedFollowers)
        
        // Then
        XCTAssertEqual(followers, decodedFollowers)
    }
    
}
