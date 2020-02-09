//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 05/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "Invalid username"
    case noInternetConnection = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case noData = "No data avilable for the user"
    case invalidData = "Invalid data recived from server"
    
    // MARK: - Favourites
    
    case couldntReadFavourites = "Couldn't find your favourites"
    case couldntParseFollower = "Couldn't save that follower"
    case followerAlreadyFavourited = "You've already favourited this user"
    
}
