//
//  User.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/7/22.
//

import Foundation

struct User: Codable, Hashable {
    var login: String
    var avatarUrl: String
    var name: String?
    var company: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl : String
    var following: Int
    var followers: Int
    var createdAt: String
}
