//
//  Date+Ext.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 8/13/22.
//

import Foundation

extension Date {
    
    func convertDateToAString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
}
