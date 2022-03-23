//
//  NetworkManager.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

class NetworkManager {
    
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()

    // MARK: - Properties
    
    private let baseURL = "https://api.github.com"
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: - API Requests
    
    func getUserDetails(for username: String, completionHandler: @escaping (Result<User, NetworkError>) -> Void) {
        let endpoint = "\(baseURL)/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData) )
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completionHandler(.success(user))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from endpoint: String, completionHandler: @escaping (UIImage) -> ()) {
        let cacheKey = NSString(string: endpoint)
        
        if let image = cache.object(forKey: cacheKey) {
            completionHandler(image)
            return
        }
        
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            completionHandler(image)
        }
        
        task.resume()
    }
    
    func fetchRepositories(for user: String, completionHandler: @escaping (Result<[Repository], NetworkError>) -> Void) {
        let endpoint = "\(baseURL)/users/\(user)/repos"
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData) )
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let repositories = try decoder.decode([Repository].self, from: data)
                completionHandler(.success(repositories))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func fetchCommits(for user: String, for repository: String, completionHandler: @escaping (Result<[Commit], NetworkError>) -> Void) {
        let endpoint = "\(baseURL)/repos/\(user)/\(repository)/commits"
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData) )
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let commits = try decoder.decode([Commit].self, from: data)
                completionHandler(.success(commits))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
}
