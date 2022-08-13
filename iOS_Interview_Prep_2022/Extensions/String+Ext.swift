//
//  String+Ext.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 8/13/22.
//

import Foundation

extension String {
    
    func convertStringToDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    func strToDateAndDatetoStr() -> String {
        
        guard let date = convertStringToDate() else { return "N/A" }
        
        return date.convertDateToAString()
        
    }
    
}
