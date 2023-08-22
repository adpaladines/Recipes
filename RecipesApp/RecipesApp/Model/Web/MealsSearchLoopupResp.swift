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

    var id: String {
        UUID().uuidString
    }

    var strMealThumbPreview: String {
        strMealThumb+"/preview"
    }
    
    var arrayIngredientsAndMeasures: [[String: String]] {
        let mirror = Mirror(reflecting: self)
        var data: [[String:String]] = [[:]]
        var ingredientsArrayInt_: [Int:String] = [:]
        var measuresArrayInt_: [Int:String] = [:]

        for (label, value) in mirror.children {
            if let name = label, let value = value as? String {
                if name.contains("strIngredient"), !value.isEmpty {
                    ingredientsArrayInt_[Int(String(name.last!))!] = value
                }
                if name.contains("strMeasure"), !value.isEmpty {
                    measuresArrayInt_[Int(String(name.last!))!] = value
                }
            }
        }
        
        ingredientsArrayInt_.forEach { int, value in
            var element = [String: String]()
            element[value] = measuresArrayInt_[int]
            data.append(element)
        }
        return data
    }
    
    init() {
        self.idMeal = ""
        self.strMeal = ""
        self.strDrinkAlternate = ""
        self.strCategory = ""
        self.strArea = ""
        self.strInstructions = ""
        self.strMealThumb = ""
        self.strTags = ""
        self.strYoutube = ""
        self.strIngredient1 = ""
        self.strIngredient2 = ""
        self.strIngredient3 = ""
        self.strIngredient4 = ""
        self.strIngredient5 = ""
        self.strIngredient6 = ""
        self.strIngredient7 = ""
        self.strIngredient8 = ""
        self.strIngredient9 = ""
        self.strIngredient10 = ""
        self.strIngredient11 = ""
        self.strIngredient12 = ""
        self.strIngredient13 = ""
        self.strIngredient14 = ""
        self.strIngredient15 = ""
        self.strIngredient16 = ""
        self.strIngredient17 = ""
        self.strIngredient18 = ""
        self.strIngredient19 = ""
        self.strIngredient20 = ""
        self.strMeasure1 = ""
        self.strMeasure2 = ""
        self.strMeasure3 = ""
        self.strMeasure4 = ""
        self.strMeasure5 = ""
        self.strMeasure6 = ""
        self.strMeasure7 = ""
        self.strMeasure8 = ""
        self.strMeasure9 = ""
        self.strMeasure10 = ""
        self.strMeasure11 = ""
        self.strMeasure12 = ""
        self.strMeasure13 = ""
        self.strMeasure14 = ""
        self.strMeasure15 = ""
        self.strMeasure16 = ""
        self.strMeasure17 = ""
        self.strMeasure18 = ""
        self.strMeasure19 = ""
        self.strMeasure20 = ""
        self.strSource = ""
        self.strImageSource = ""
        self.strCreativeCommonsConfirmed = ""
        self.dateModified = ""
    }
    
    init(idMeal: String, strMeal: String, strDrinkAlternate: String?, strCategory: String, strArea: String, strInstructions: String, strMealThumb: String, strTags: String?, strYoutube: String?, strIngredient1: String?, strIngredient2: String?, strIngredient3: String?, strIngredient4: String?, strIngredient5: String?, strIngredient6: String?, strIngredient7: String?, strIngredient8: String?, strIngredient9: String?, strIngredient10: String?, strIngredient11: String?, strIngredient12: String?, strIngredient13: String?, strIngredient14: String?, strIngredient15: String?, strIngredient16: String?, strIngredient17: String?, strIngredient18: String?, strIngredient19: String?, strIngredient20: String?, strMeasure1: String?, strMeasure2: String?, strMeasure3: String?, strMeasure4: String?, strMeasure5: String?, strMeasure6: String?, strMeasure7: String?, strMeasure8: String?, strMeasure9: String?, strMeasure10: String?, strMeasure11: String?, strMeasure12: String?, strMeasure13: String?, strMeasure14: String?, strMeasure15: String?, strMeasure16: String?, strMeasure17: String?, strMeasure18: String?, strMeasure19: String?, strMeasure20: String?, strSource: String?, strImageSource: String?, strCreativeCommonsConfirmed: String?, dateModified: String?) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strDrinkAlternate = strDrinkAlternate
        self.strCategory = strCategory
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.strTags = strTags
        self.strYoutube = strYoutube
        self.strIngredient1 = strIngredient1
        self.strIngredient2 = strIngredient2
        self.strIngredient3 = strIngredient3
        self.strIngredient4 = strIngredient4
        self.strIngredient5 = strIngredient5
        self.strIngredient6 = strIngredient6
        self.strIngredient7 = strIngredient7
        self.strIngredient8 = strIngredient8
        self.strIngredient9 = strIngredient9
        self.strIngredient10 = strIngredient10
        self.strIngredient11 = strIngredient11
        self.strIngredient12 = strIngredient12
        self.strIngredient13 = strIngredient13
        self.strIngredient14 = strIngredient14
        self.strIngredient15 = strIngredient15
        self.strIngredient16 = strIngredient16
        self.strIngredient17 = strIngredient17
        self.strIngredient18 = strIngredient18
        self.strIngredient19 = strIngredient19
        self.strIngredient20 = strIngredient20
        self.strMeasure1 = strMeasure1
        self.strMeasure2 = strMeasure2
        self.strMeasure3 = strMeasure3
        self.strMeasure4 = strMeasure4
        self.strMeasure5 = strMeasure5
        self.strMeasure6 = strMeasure6
        self.strMeasure7 = strMeasure7
        self.strMeasure8 = strMeasure8
        self.strMeasure9 = strMeasure9
        self.strMeasure10 = strMeasure10
        self.strMeasure11 = strMeasure11
        self.strMeasure12 = strMeasure12
        self.strMeasure13 = strMeasure13
        self.strMeasure14 = strMeasure14
        self.strMeasure15 = strMeasure15
        self.strMeasure16 = strMeasure16
        self.strMeasure17 = strMeasure17
        self.strMeasure18 = strMeasure18
        self.strMeasure19 = strMeasure19
        self.strMeasure20 = strMeasure20
        self.strSource = strSource
        self.strImageSource = strImageSource
        self.strCreativeCommonsConfirmed = strCreativeCommonsConfirmed
        self.dateModified = dateModified
    }
    
    init(from mealEntity: MealEntity) {
        self.idMeal = mealEntity.idMeal ?? UUID().uuidString
        self.strMeal = mealEntity.strMeal ?? "No name meal"
        self.strDrinkAlternate = mealEntity.strDrinkAlternate
        self.strCategory = mealEntity.strCategory ?? "N/A"
        self.strArea = mealEntity.strArea ?? "N/A"
        self.strInstructions = mealEntity.strInstructions ?? "N/A"
        self.strMealThumb = mealEntity.strMealThumb ?? ""
        self.strTags = mealEntity.strTags
        self.strYoutube = mealEntity.strYoutube
        self.strIngredient1 = mealEntity.strIngredient1
        self.strIngredient2 = mealEntity.strIngredient2
        self.strIngredient3 = mealEntity.strIngredient3
        self.strIngredient4 = mealEntity.strIngredient4
        self.strIngredient5 = mealEntity.strIngredient5
        self.strIngredient6 = mealEntity.strIngredient6
        self.strIngredient7 = mealEntity.strIngredient7
        self.strIngredient8 = mealEntity.strIngredient8
        self.strIngredient9 = mealEntity.strIngredient9
        self.strIngredient10 = mealEntity.strIngredient10
        self.strIngredient11 = mealEntity.strIngredient11
        self.strIngredient12 = mealEntity.strIngredient12
        self.strIngredient13 = mealEntity.strIngredient13
        self.strIngredient14 = mealEntity.strIngredient14
        self.strIngredient15 = mealEntity.strIngredient15
        self.strIngredient16 = mealEntity.strIngredient16
        self.strIngredient17 = mealEntity.strIngredient17
        self.strIngredient18 = mealEntity.strIngredient18
        self.strIngredient19 = mealEntity.strIngredient19
        self.strIngredient20 = mealEntity.strIngredient20
        self.strMeasure1 = mealEntity.strMeasure1
        self.strMeasure2 = mealEntity.strMeasure2
        self.strMeasure3 = mealEntity.strMeasure3
        self.strMeasure4 = mealEntity.strMeasure4
        self.strMeasure5 = mealEntity.strMeasure5
        self.strMeasure6 = mealEntity.strMeasure6
        self.strMeasure7 = mealEntity.strMeasure7
        self.strMeasure8 = mealEntity.strMeasure8
        self.strMeasure9 = mealEntity.strMeasure9
        self.strMeasure10 = mealEntity.strMeasure10
        self.strMeasure11 = mealEntity.strMeasure11
        self.strMeasure12 = mealEntity.strMeasure12
        self.strMeasure13 = mealEntity.strMeasure13
        self.strMeasure14 = mealEntity.strMeasure14
        self.strMeasure15 = mealEntity.strMeasure15
        self.strMeasure16 = mealEntity.strMeasure16
        self.strMeasure17 = mealEntity.strMeasure17
        self.strMeasure18 = mealEntity.strMeasure18
        self.strMeasure19 = mealEntity.strMeasure19
        self.strMeasure20 = mealEntity.strMeasure20
        self.strSource = mealEntity.strSource
        self.strImageSource = mealEntity.strImageSource
        self.strCreativeCommonsConfirmed = mealEntity.strCreativeCommonsConfirmed
        self.dateModified = mealEntity.dateModified
    }
}
