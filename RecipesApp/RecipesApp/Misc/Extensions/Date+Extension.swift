//
//  Date+Extension.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/16/23.
//

import Foundation

extension Date {
    
    var timeInterValInteger: Int {
        let someDate = Date()
        let timeInterval = someDate.timeIntervalSince1970
        let myInt = Int(timeInterval)
        return myInt
    }
}
