//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 08/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthAndYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    static var mockDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: "2020-02-16T16:15:35+0000")!
    }
    
}
