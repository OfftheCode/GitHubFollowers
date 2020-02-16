//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 05/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

protocol NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }
        
        task.resume()
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let session: NetworkSession
    
    private let baseURL = "https://api.github.com/users/"
    private let perPageFollowers = 100
    
    let cache = NSCache<NSString, UIImage>()
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], GFError>) -> Void) {
        
        let endpoint = baseURL + "\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        session.loadData(from: url) { (data, response, error) in
            guard error == nil else {
                completed(.failure(.noInternetConnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
    }
    
    func getUserInfo(with username: String, completed: @escaping(Result<User, GFError>) -> Void) {
        
        let stringURL = baseURL + username
        
        guard let url = URL(string: stringURL) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        session.loadData(from: url) { data, response, error in
            guard error == nil else {
                completed(.failure(.noInternetConnection))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }

    }
    
    func downloadImage(for urlString: String, completion: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        session.loadData(from: url) { [weak self] data, response, error in
            guard let self = self,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
    }
    
}
