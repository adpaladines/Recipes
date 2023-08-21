//
//  DetailsMealScreen.swift
//  RecipesApp
//
//  Created by andres paladines on 8/20/23.
//

import SwiftUI
//import SwiftUI

struct MealDetailsMediaScreen: View {
    
    var imageUrl: String?
    var videoUrl: String?
    
    var body: some View {
        VStack {
            
            
            Spacer()
        }
    }
}

struct MealDetailsMediaScreen_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsMediaScreen()
    }
}

struct MealDetailsScreen: View {
    
    @StateObject var mealsViewModel = MealsViewModel(networkManager: NetworkManager())
    @State var urlString: String = ""
    var mealPewview: MealPreview
    
    var body: some View {
        
        VStack {
            MealDetailsHeaderView(title: mealPewview.strMeal)
            ScrollView {
                MealDetailsSocialView(title: mealPewview.strMeal, url: URL(string: mealsViewModel.selectedMeal?.strSource ?? ""))
                    .padding(.horizontal)
                Text(mealsViewModel.selectedMeal?.strInstructions ?? "")
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .toolbar(.hidden)
            .onAppear {
                mealsViewModel.fetchMealById(mealPewview.idMeal)
            }
        }
    }
}

struct DetailsMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsScreen(mealPewview: MealPreview(strMeal: "Beef with salt", strMealThumb: "https://www.themealdb.com/images/media/meals/1548772327.jpg", idMeal: "1548772327"))
    }
}
