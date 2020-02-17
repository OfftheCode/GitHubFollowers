//
//  FollowersListVCTests.swift
//  GHFollowersTests
//
//  Created by Piotr Szadkowski on 17/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit
import XCTest
@testable import GHFollowers

class FollowersListVCTests: XCTestCase {
    
    var followersVC: FollowersListVC!
    
    override func setUp() {
        let networkManager = NetworkManager(session: NetworkSessionMock())
        followersVC = FollowersListVC(networkManager: networkManager)
    }
    
    override func tearDown() {
        followersVC = nil
    }
    
    func testSettingUsernameSetsTitle() {
        // Given
        followersVC.username = "Johnatan"
        // Then
        XCTAssertEqual(followersVC.title, "Johnatan")
    }
    
    func testUpdateUIUpdatesFollowersNumber() {
        // Given
        followersVC.followers = []
    }
    
}
