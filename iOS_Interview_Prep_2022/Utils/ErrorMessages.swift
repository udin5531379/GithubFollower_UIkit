//
//  ErrorMessages.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/7/22.
//

import Foundation

enum ErrorMessages: String, Error {
    case urlProblem = "Some problem with URL. Please re-try!"
    case connectionProblem = "Plese check your internet connection"
    case invalidResponse = "Invalid response. Please try again later"
    case noData = "Don't have the data."
    case failedDecode = "Failed to decode JSON data."
    case failedToAddFavorites = "Failed to add this user to favorites. Please try again."
    case alreayInFavourites = "This user is already in the favorites!"
}
