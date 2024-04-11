//
//  PathUrl.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/16/23.
//

import Foundation

struct PathUrls {
    private(set) var path: String
    private(set) var queryString: String
    
    private init(path: String, queryString: String) {
        self.path = path
        self.queryString = queryString
    }
    
    static func searchByName(_ str: String) -> PathUrls {
        PathUrls(path: "search.php?s=", queryString: str)
    }
        
    static let searchByFirstLetter = PathUrls(path: "search.php?f=")
    static let filterByCategory = PathUrls(path: "filter.php?c=")
    static let filterByArea = PathUrls(path: "filter.php?f=")
    static let filterByMainIngredient = PathUrls(path: "filter.php?i=")
    static let lookupForId = PathUrls(path: "lookup.php?i=")
    static let getRandomMeal = PathUrls(path: "random.php")
    static let getCategories = PathUrls(path: "categories.php")
    
    static func filterByTopic(topic: Topic) -> PathUrls {
        return PathUrls(path: "list.php?\(topic.rawValue)")
    }
}

enum PathUrl {
    case searchByName(str: String)
    case searchByFirstLetter(str: String)
    case filterByCategory(str: String)
    case filterByArea(str: String)
    case filterByMainIngredient(str: String)
    case lookupForId(str: String)
    case getRandomMeal
    case getCategories
    case filterByTopic(topic: Topic)

    func getString() -> String {
        var newValue = "category/"
        switch self {
        case .searchByName(let str):
            newValue = "search.php?s=\(str)"
        case .searchByFirstLetter(let str):
            newValue = "search.php?f=\(str)"

        case .filterByCategory(let str):
            newValue = "filter.php?c=\(str)"
        case .filterByArea(let str):
            newValue = "filter.php?f=\(str)"
        case .filterByMainIngredient(let str):
            newValue = "filter.php?i=\(str)"

        case .lookupForId(let str):
            newValue = "lookup.php?i=\(str)"

        case .getRandomMeal:
            newValue = "random.php"
        case .getCategories:
            newValue = "categories.php"

        case .filterByTopic(topic: let topic):
            newValue = "list.php?\(topic.rawValue)"
        }
        return newValue
    }
}
