//
//  CategoriesResponse.swift
//  RecipesApp
//
//  Created by Consultant on 8/15/23.
//

import Foundation

// MARK: - CategoriesResponse
struct CategoriesResponse: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable, Identifiable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String

    var id: Int {
        guard let newId = Int(idCategory) else {
            let someDate = Date()
            let timeInterval = someDate.timeIntervalSince1970
            let myInt = Int(timeInterval)
            return myInt
        }
        return newId
    }
}
