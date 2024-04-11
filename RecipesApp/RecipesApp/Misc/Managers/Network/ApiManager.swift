//
//  ApiManager.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/15/23.
//

/*
 RESOURCES:
 Search meal by name: https://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata
 List all meals by first letter: https://www.themealdb.com/api/json/v1/1/search.php?f=a

 Filter by Category: https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
 Filter by Area: https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian
 Filter by main ingredient: https://www.themealdb.com/api/json/v1/1/filter.php?i=chicken_breast

 Lookup full meal details by id https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772
 Random meal: https://www.themealdb.com/api/json/v1/1/random.php
 Categories: https://www.themealdb.com/api/json/v1/1/categories.php
 List all Categories, Area, Ingredients: https://www.themealdb.com/api/json/v1/1/list.php? { c=list or a=list or i=list }


 class ExampleClass {
     func functionality() {
         ApiManager.api(.search(str: "example"))
     }
 }
 */

import Foundation

//struct ApiManager {
//
//    private static let baseUrl = "https://www.themealdb.com/"
//
//    private static let api = "api/json/v1/1/"
//
//    static func image(_ name: String) -> String? {
//        guard let urlName = name
//            .replacingOccurrences(of: " ", with: "_")
//            .lowercased()
//            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        else {
//            return nil
//        }
//        return "images/ingredients/\(urlName).png"
//    }
//
//    static func api(_ pathString: PathUrl? = nil) -> String {
//        guard let newPath = pathString else {
//            return baseUrl + api
//        }
//
//        let path = baseUrl + api + newPath.getString()
//        return path
//    }
//
//    static func fake(_ file: FakeFile) -> String {
//        file.rawValue
//    }
//    
//}



struct ApiManager {

    private static let baseUrl = "https://www.themealdb.com/"
    private static let api = "api/json/v1/1/"

    static func api(_ pathUrl: PathUrls) -> String {
        return baseUrl + api + pathUrl.path + pathUrl.queryString
    }

    static func fake(_ file: FakeFile) -> String {
        return file.rawValue
    }
    
    static func image(_ name: String) -> String? {
        guard let urlName = name
            .replacingOccurrences(of: " ", with: "_")
            .lowercased()
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        else {
            return nil
        }
        return "images/ingredients/\(urlName).png"
    }
}

