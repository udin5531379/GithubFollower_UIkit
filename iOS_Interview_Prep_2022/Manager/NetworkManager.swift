//
//  NetworkManager.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/7/22.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager() //singleton
    
    private init() {}
    
    let cache = NSCache<NSString, UIImage>()
    private let baseURL = "https://api.github.com/users/"
    
    func getFollowers(username: String, page: Int, completed: @escaping (Result<[Follower], ErrorMessages>) -> Void) {
        let url = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: url) else {
            completed(.failure(.urlProblem))
            return
        }
        //url bat error aayena bhaney chahe continue to next stage.
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error { //if error bhetayo bhaney chahe stop completely
                completed(.failure(.connectionProblem))
                return
            }
            
            //bhetayena bhaney chahe continue to guard...
            
            guard let responseCode = response as? HTTPURLResponse, responseCode.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            //response code ma error bhetayena bhaney chaeh continue to guard
            
            guard let data = data else {
                completed(.failure(.noData))
                return
            }
            //data ma kei error chaina bhanye chahe continue...
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
                
            } catch {
                completed(.failure(.failedDecode))
            }
         }
        
        task.resume()
        
    }
}
