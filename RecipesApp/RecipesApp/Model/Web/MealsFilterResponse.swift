//
//  MealsFilterResponse.swift
//  RecipesApp
//
//  Created by Consultant on 8/15/23.
//
// https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
// Used in the main list of meals

import Foundation

// MARK: - MealsResponse
struct MealsFilterResponse: Codable, Identifiable {
    let meals: [MealPreview]
    var strCategory: String?

    var id: String {
        UUID().uuidString
    }
}

// MARK: - Meal
struct MealPreview: Codable, Identifiable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String

    var id: String {
        UUID().uuidString
    }

    var strMealThumbPreview: String {
        strMealThumb+"/preview"
    }
    

    init(strMeal: String, strMealThumb: String, idMeal: String) {
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
    
    init() {
        self.strMeal = ""
        self.strMealThumb = ""
        self.idMeal = ""
    }
}
