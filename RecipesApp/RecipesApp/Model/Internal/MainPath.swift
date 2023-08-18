//
//  MainPath.swift
//  RecipesApp
//
//  Created by Consultant on 8/18/23.
//

import Foundation

typealias Coordinable = Hashable & Equatable & CaseIterable & Identifiable

enum MainPath: Coordinable {

    case login
    case tabBarView
    case mainList
    case favoritesList
    case mealDetails(meal: Meal)
    case userOptions

    var id: String {
        String(reflecting: self)
    }

    static func == (lhs: MainPath, rhs: MainPath) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(reflecting: self))
    }

    static var allCases: [MainPath] = [
        MainPath.login,
        MainPath.tabBarView,
        MainPath.mainList,
        MainPath.favoritesList,
        MainPath.mealDetails(meal: Meal()),
        MainPath.userOptions
    ]

    var path: String {
//        String(reflecting: self)
        switch self {
        case .login:
            return "login"
        case .tabBarView:
            return "tabBarView"
        case .mainList:
            return "mainList"
        case .favoritesList:
            return "favoritesList"
        case .mealDetails(_):
            return "mealDetails"
        case .userOptions:
            return "userOptions"
        }
    }
}
