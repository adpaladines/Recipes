//
//  MainCoordinator.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/16/23.
//

import Foundation
import SwiftUI

@MainActor
class MainCoordinator: ObservableObject {

    @Published var path = NavigationPath()
    
    func goTo(_ page: MainPath) {
        path.append(page)
    }
    
    @ViewBuilder
    func getPage(_ page: MainPath) -> some View {
        switch page {
        case .login: LoginScreen()
        case .emailLogin: EmailLoginScreen()
        case .tabBarView: TabBarScreen(presentingModal: false)
        case .mainList: Text("2")
        case .favoritesList: Text("3")
        case .mealDetails(let meal):
            MealDetailsScreen(mealPewview: meal)
        case .userOptions:
            EmptyView()
        case .loginEmail:
            NewLoginScreen(titleBar: "Login with email")
        case .registerEmail:
            NewLoginScreen(titleBar: "Register with email")
        case .preferredCategories(let categories):
            MyCategoriesListScreen(categories: categories, listTitle: "My categories")
        case .mealsByPreferredCategoryScreen(let title, let category):
            MealsByPreferredCategoryScreen(typeSelected: category, title: title)
        }
    }
}

struct MyViewControllerWrapper: UIViewControllerRepresentable {

    @EnvironmentObject var coordinator: MainCoordinator
    var string: String

    func makeUIViewController(context: Context) -> MyViewController {
        let storyboard = UIStoryboard(name: "MyStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MyViewController") as? MyViewController else {
            return MyViewController()
        }
        vc.mainCoordinator = coordinator
//        vc.titleView = string
        return vc
    }

    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {

    }
}
