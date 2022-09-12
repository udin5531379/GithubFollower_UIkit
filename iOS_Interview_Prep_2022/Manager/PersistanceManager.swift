//
//  PersistanceManager.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 9/1/22.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    static let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completion: @escaping (ErrorMessages?) -> Void) {
        
        retriveFavoritesFromUserDefaults { result in
            switch result {
            case .success(let favorites):
                var favoritesArray = favorites //since the favorites we get from .success is immutable.
                
                switch actionType {
                case .add:
                    
                    guard !favoritesArray.contains(favorite) else {
                        completion(.alreayInFavourites)
                        return
                    }
                    
                    favoritesArray.append(favorite)
                    
                case .remove:
                    favoritesArray.removeAll { follower in
                        follower.login == favorite.login
                    }
                }
                
            completion(saveToUserDefaults(favourites: favoritesArray))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retriveFavoritesFromUserDefaults(completion: @escaping (Result<[Follower], ErrorMessages>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            //retrive garna lai decode garnu parcha
            let decode = JSONDecoder()
            let favorites = try decode.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.failedToAddFavorites))
        }
    }
    
    static func saveToUserDefaults(favourites: [Follower]) -> ErrorMessages? {
        do {
            //save garna lai encode garnu parcha.
            let encoder = JSONEncoder()
            let savedFavorites = try encoder.encode(favourites)
            defaults.set(savedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .failedToAddFavorites
        }
    }
}
