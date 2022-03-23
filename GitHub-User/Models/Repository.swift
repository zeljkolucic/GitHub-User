//
//  Repository.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import Foundation

struct Repository: Codable {
    
    let name: String
    let updatedAt: Date
    let language: String?
    let openIssues: Int
    
}
