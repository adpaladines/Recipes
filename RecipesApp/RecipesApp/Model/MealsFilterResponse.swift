//
//  MealsFilterResponse.swift
//  RecipesApp
//
//  Created by Consultant on 8/15/23.
//

import Foundation

// MARK: - MealsResponse
struct MealsFilterResponse: Codable {
    let meals: [MealPreview]
}

// MARK: - Meal
struct MealPreview: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}


