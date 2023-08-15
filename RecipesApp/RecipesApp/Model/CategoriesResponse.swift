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
struct Category: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
