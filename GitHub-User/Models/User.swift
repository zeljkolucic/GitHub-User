//
//  User.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import Foundation

struct User: Codable, Hashable {
    
    let login: String
    let name: String
    let avatarUrl: String
    let company: String?
    let reposUrl: String
    let createdAt: Date
    
}
