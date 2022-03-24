//
//  Calendar+Extension.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 24.3.22..
//

import Foundation

extension Calendar {
    
    func daysSinceNow(date: Date) -> Int {
        let numberOfDays = dateComponents([.day], from: date, to: Date())
        return numberOfDays.day!
    }
    
}
