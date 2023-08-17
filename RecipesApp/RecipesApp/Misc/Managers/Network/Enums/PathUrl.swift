//
//  PathUrl.swift
//  RecipesApp
//
//  Created by Consultant on 8/16/23.
//

import Foundation

enum PathUrl {
    case searchName(str: String)
    case searchFirstLetter(str: String)
    case filterCategory(str: String)
    case filterArea(str: String)
    case filterMainIngredient(str: String)
    case lookupForId(str: String)
    case randomMeal
    case categories
    case listBy(topic: Topic)

    func getString() -> String {
        var newValue = "category/"
        switch self {
        case .searchName(let str):
            newValue = "search.php?s=\(str)"
        case .searchFirstLetter(let str):
            newValue = "search.php?f=\(str)"

        case .filterCategory(let str):
            newValue = "filter.php?c=\(str)"
        case .filterArea(let str):
            newValue = "filter.php?f=\(str)"
        case .filterMainIngredient(let str):
            newValue = "filter.php?i=\(str)"

        case .lookupForId(let str):
            newValue = "lookup.php?i=\(str)"

        case .randomMeal:
            newValue = "random.php"
        case .categories:
            newValue = "categories.php"

        case .listBy(topic: let topic):
            newValue = "list.php?\(topic.rawValue)"
        }
        return newValue
    }
}
