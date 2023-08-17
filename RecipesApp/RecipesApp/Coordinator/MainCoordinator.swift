//
//  MainCoordinator.swift
//  RecipesApp
//
//  Created by andres paladines on 8/16/23.
//

import Foundation
import SwiftUI

@MainActor
class MainCoordinator: ObservableObject {

    @Published var path = NavigationPath()
    
    func goto(_ page: MainPath) {
        path.append(page)
    }
    
    @ViewBuilder
    func getPage(_ page: MainPath) -> some View {
        switch page {
        case .login:
            Text("1")
        case .mainList:
            Text("2")
        case .favoritesList:
            Text("3")
        case .mealDetails(let meal):
            Text(meal.strMeal)
        case .userOptions:
            EmptyView()
        }
    }
}

enum MainPath: Hashable, Equatable, CaseIterable, Identifiable {

    case login
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
        MainPath.mainList,
        MainPath.favoritesList,
        MainPath.mealDetails(meal: Meal()),
        MainPath.userOptions
    ]
    
    var path: String {
        switch self {
        case .login:
            return "login"
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
