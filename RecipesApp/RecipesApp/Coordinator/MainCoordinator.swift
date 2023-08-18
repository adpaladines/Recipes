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
            LoginScreen()
        case .tabBarView:
            TabBarScreen(presentingModal: false)
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
