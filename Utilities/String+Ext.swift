//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 08/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        return formatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let data = self.convertToDate() else {
            return "N/A"
        }
        return data.convertToMonthAndYear()
    }
    
}
