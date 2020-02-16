//
//  NetworkSessionMock.swift
//  GHFollowersTests
//
//  Created by Piotr Szadkowski on 16/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation
@testable import GHFollowers

class NetworkSessionMock: NetworkSession {
    
    var data: Data?
    var error: Error?
    var response: URLResponse? = HTTPURLResponse(url: URL(fileURLWithPath: "url"), statusCode: 200, httpVersion: nil, headerFields: nil)
    
    func loadData(from url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
    }
}
