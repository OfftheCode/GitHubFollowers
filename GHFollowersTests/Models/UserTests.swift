//
//  UserTests.swift
//  GHFollowersTests
//
//  Created by Piotr Szadkowski on 17/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation
import XCTest
@testable import GHFollowers

class UserTests: XCTestCase {
    
    var user: User!
    
    override func setUp() {
        user = User.mock
    }
    
    override func tearDown() {
        user = nil
    }
    
    func testCodableConformance() throws {
        let encodedUser = try GFEncoder.enocde(user: user)
        let decodedUser = try GFDecoder.decodeUser(from: encodedUser)
        XCTAssertEqual(user, decodedUser)
    }
    
}
