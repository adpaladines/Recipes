//
//  MainView.swift
//  RecipesApp
//
//  Created by andres paladines on 8/16/23.
//

import Foundation
import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    let meal = Meal()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getPage(.mealDetails(meal: meal))
                .navigationDestination(for: MainPath.self) { page in
                    coordinator.getPage(page)
                }
        }

    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
            .environmentObject(MainCoordinator())
    }
}
