//
//  MainPath.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/18/23.
//

import Foundation

enum MainPath: Hashable, Equatable, CaseIterable, Identifiable {

    case login
    case emailLogin
    case tabBarView
    case mainList
    case favoritesList
    case mealDetails(meal: MealPreview)
    case userOptions
    case loginEmail
    case registerEmail
    case preferredCategories(categories: [Category])
    case mealsByPreferredCategoryScreen(title: String, category: String)
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(reflecting: self))
    }
    
    static func == (lhs: MainPath, rhs: MainPath) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    static var allCases: [MainPath] = [
        MainPath.login,
        MainPath.tabBarView,
        MainPath.mainList,
        MainPath.favoritesList,
        MainPath.mealDetails(meal: MealPreview()),
        MainPath.userOptions,
        MainPath.emailLogin,
        MainPath.loginEmail,
        MainPath.registerEmail,
        MainPath.preferredCategories(categories: []),
        MainPath.mealsByPreferredCategoryScreen(title: "", category: "")
    ]
    
    var id: String {
        String(reflecting: self)
    }
}
