//
//  ApiManager.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/15/23.
//

import Foundation

struct ApiManager {

    private static let baseUrl = "https://www.themealdb.com/"

    private static let api = "api/json/v1/1/"

    static func api(_ category: PathUrl? = nil) -> String {
        guard let cat = category else {
            return api
        }

        let path = api + cat.getString()
        return path
    }

    static func fake(_ file: FakeFile) -> String {
        file.rawValue
    }

    static func userInfo() -> String {
        "https://2d9f8f00-62f3-49ba-bde9-d72c241b94d7.mock.pstmn.io/getUserInfo"
    }
}

enum PathUrl {
    case list
    case smartphones
    case laptops
    case fragrances
    case skincare
    case groceries
    case homeDecoration
    case furniture
    case tops
    case womensDresses
    case womensShoes
    case mensShirts
    case mensShoes
    case mensWatches
    case womensWatches
    case womensBags
    case womensJewellery
    case sunglasses
    case automotive
    case motorcycle
    case lighting
    case search(text: String)

    func getString() -> String {
        var newValue = "category/"
        switch self {
        case .list:
            newValue = "categories"
        case .smartphones:
            newValue += "smartphones"
        case .laptops:
            newValue += "laptops"
        case .fragrances:
            newValue += "fragrances"
        case .skincare:
            newValue += "skincare"
        case .groceries:
            newValue += "groceries"
        case .homeDecoration:
            newValue += "home-decoration"
        case .furniture:
            newValue += "furniture"
        case .tops:
            newValue += "tops"
        case .womensDresses:
            newValue += "womens-dresses"
        case .womensShoes:
            newValue += "womens-shoes"
        case .mensShirts:
            newValue += "mens-shirts"
        case .mensShoes:
            newValue += "mens-shoes"
        case .mensWatches:
            newValue += "mens-watches"
        case .womensWatches:
            newValue += "womens-watches"
        case .womensBags:
            newValue += "womens-bags"
        case .womensJewellery:
            newValue += "womens-jewellery"
        case .sunglasses:
            newValue += "sunglasses"
        case .automotive:
            newValue += "automotive"
        case .motorcycle:
            newValue += "motorcycle"
        case .lighting:
            newValue += "lighting"
        case .search(let text):
            newValue = "search?q=\(text)"
        }
        return newValue
    }
}
