//
//  CommitDetails.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import Foundation

struct CommitDetails: Codable {
    
    let message: String?
    let author: Author
    
}
