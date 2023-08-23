//
//  MealsByPreferredCategoryScreen.swift
//  RecipesApp
//
//  Created by andres paladines on 8/23/23.
//

import SwiftUI

struct MealsByPreferredCategoryScreen: View {
    
    @EnvironmentObject var orientationInfo: OrientationInfo
    @StateObject var mealsViewModel = MealsViewModel(networkManager: NetworkManager())
    @StateObject var categoriesViewModel = CategoriesViewModel(networkManager: NetworkManager())
    
    var typeSelected: String
    var title: String
    
    var body: some View {
        VStack {
            CommonHeaderBar(title: title)
                .padding(.horizontal)
            
            VStack(alignment: .center) {
                GridMealsView(mealsViewModel: mealsViewModel, category: typeSelected)
            }
            .padding(.horizontal)
            Spacer()
        }
        .task {
            categoriesViewModel.fetchAllCategories()
        }
        .toolbar(.hidden)
    }
    
}

struct MealsByPreferredCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        MealsByPreferredCategoryScreen(typeSelected: "Beef", title: "Beef")
            .environmentObject(OrientationInfo())
    }
}
