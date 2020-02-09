//
//  PersistanceManager.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 09/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation

enum PersistanceActionType {
    case save, remove
}

enum PersistanceManager {
    
    private static let defaults = UserDefaults.standard
    
    private enum Keys {
        static let kFavourites = "key_favourites"
    }
    
    static func updateFavourites(
        with follower: Follower,
        actionType: PersistanceActionType,
        to defaults: UserDefaults = defaults,
        completion: @escaping (GFError?) -> Void
    ) {

        retriveFavoruites { result in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(var followers):
                switch actionType {
                case .save:
                    guard !followers.contains(follower) else {
                        completion(.followerAlreadyFavourited)
                        return
                    }
                    followers.append(follower)
                case .remove:
                    followers.removeAll { retrivedFollower -> Bool in
                        retrivedFollower == follower
                    }
                }
                
                completion(saveFavourites(followers))
                
            }
            
        }
    }
    
    static func retriveFavoruites(
        from defaults: UserDefaults = defaults,
        completion: @escaping (Result<[Follower], GFError>
    ) -> Void) {
        
        guard let data = defaults.object(forKey: Keys.kFavourites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let followers = try decoder.decode([Follower].self, from: data)
            completion(.success(followers))
        } catch {
            completion(.failure(.couldntReadFavourites))
        }
        
    }
    
    private static func saveFavourites(
        _ favourites: [Follower],
        to defaults: UserDefaults = defaults
    ) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favourites)
            defaults.set(data, forKey: Keys.kFavourites)
            return nil
        } catch {
            return .couldntParseFollower
        }
        
    }
    
}
