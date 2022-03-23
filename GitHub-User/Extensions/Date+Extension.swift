//
//  Date+Extension.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
