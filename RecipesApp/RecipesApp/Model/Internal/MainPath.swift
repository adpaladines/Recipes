//
//  MainPath.swift
//  RecipesApp
//
//  Created by Consultant on 8/18/23.
//

import Foundation

enum MainPath: Hashable, Equatable, CaseIterable, Identifiable {

    case login
    case emailLogin
    case tabBarView
    case mainList
    case favoritesList
    case mealDetails(meal: Meal)
    case userOptions

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
        MainPath.mealDetails(meal: Meal()),
        MainPath.userOptions,
        MainPath.emailLogin
    ]
    
    var id: String {
        String(reflecting: self)
    }
}
