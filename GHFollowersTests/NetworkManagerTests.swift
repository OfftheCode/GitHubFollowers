//
//  NetworkManagerTests.swift
//  GHFollowersTests
//
//  Created by Piotr Szadkowski on 16/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import XCTest
@testable import GHFollowers

class NetworkManagerTests: XCTestCase {
    
    var session: NetworkSessionMock!
    var manager: NetworkManager!
    var user: User!
    
    override func setUp() {
        session = NetworkSessionMock()
        manager = NetworkManager(session: session)
        user = User(login: "Foo", avatarUrl: "", name: "Jordan Bordan", location: "", bio: "", publicRepos: 2, publicGists: 0, htmlUrl: "", following: 31, followers: 33, createdAt: Date.mockDate)
    }
    
    override func tearDown() {
        manager = nil
        session = nil
        user = nil
    }
    
    func testValidResponseProperEncoding() {
        // Given
        session.data = GFEncoder.enocde(user: user)
        
        // When
        var result: Result<User, GFError>?
        manager.getUserInfo(with: "") { result = $0 }
        
        // Then
        XCTAssertEqual(result, .success(user))
    }
    
    func testReturnErrorWhenDataWronglyEncoded() {
        // Given
        session.data = try? JSONEncoder().encode(user)
        
        // When
        var result: Result<User, GFError>?
        manager.getUserInfo(with: "") { result = $0 }
        
        // Then
        XCTAssertEqual(result, .failure(.invalidData))
    }
    
}
