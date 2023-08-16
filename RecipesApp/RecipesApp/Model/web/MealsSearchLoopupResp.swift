//
//  MealsSearchLoopupResp.swift
//  RecipesApp
//
//  Created by Consultant on 8/15/23.
//

import Foundation

// MARK: - MealsResp
struct MealsSearchLookupResp: Codable, Identifiable {
    let meals: [Meal]

    var id: Int {
        let someDate = Date()
        let timeInterval = someDate.timeIntervalSince1970
        let myInt = Int(timeInterval)
        return myInt
    }
}


struct Meal: Codable, Identifiable {
    let idMeal, strMeal: String
    let strDrinkAlternate: String?
    let strCategory, strArea, strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4: String?
    let strIngredient5, strIngredient6, strIngredient7, strIngredient8: String?
    let strIngredient9, strIngredient10, strIngredient11, strIngredient12: String?
    let strIngredient13, strIngredient14, strIngredient15: String?
    let strIngredient16, strIngredient17, strIngredient18, strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1, strMeasure2, strMeasure3, strMeasure4: String?
    let strMeasure5, strMeasure6, strMeasure7, strMeasure8: String?
    let strMeasure9, strMeasure10, strMeasure11, strMeasure12: String?
    let strMeasure13, strMeasure14, strMeasure15: String?
    let strMeasure16, strMeasure17, strMeasure18, strMeasure19: String?
    let strMeasure20, strSource, strImageSource, strCreativeCommonsConfirmed: String?
    let dateModified: String?

    var id: Int {
        guard let myId = Int(idMeal) else {
            return Date().timeInterValInteger
        }
        return myId
    }

    var strMealThumbPrwview: String {
        strMealThumb+"/preview"
    }
}
