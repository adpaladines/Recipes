//
//  DetailsMealScreen.swift
//  RecipesApp
//
//  Created by andres paladines on 8/20/23.
//

import SwiftUI
//import SwiftUI

struct MealDetailsIngredientsView: View {
    
    var selectedMeal: Meal
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(selectedMeal.arrayIngredientsAndMeasures, id: \.rawValue) { ingredient in
                if let ingredient = ingredient.first {
                    HStack {
                        Text(ingredient.key)
                            .font(.body)
                            .fontWeight(.medium)
                        Spacer()
                        Text(ingredient.value)
                            .font(.body)
                            .fontWeight(.regular)
                    }
                }else {
                    HStack {
                        Text("Ingredients")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Text("Measure")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                
            }
        }
    }
}

struct MealDetailsIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsIngredientsView(selectedMeal: Meal())
    }
}

struct MealDetailsScreen: View {
    
    @StateObject var mealsViewModel = MealsViewModel(networkManager: NetworkManager())
    @StateObject var favotiesViewModel = FavoriteMealsViewModel()
    
    @State var isFavorite: Bool = false
    
    var mealPewview: MealPreview
    
    var body: some View {
        
        VStack(alignment: .leading) {
            MealDetailsHeaderView(title: mealPewview.strMeal, selectedMeal: mealsViewModel.selectedMeal, isFavorite: $isFavorite)
            
            ScrollView {
                VStack(spacing: 4) {
                    Text("Media")
                        .font(.title)
                        .padding(.top)
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 48, height: 3)
                        .foregroundColor(.green)
                    
                }
                .padding(.horizontal)
                MealDetailsMediaView(
                    imageUrl: mealsViewModel.selectedMeal?.strMealThumb,
                    videoUrl: mealsViewModel.selectedMeal?.strYoutube
                )
                MealDetailsSocialView(
                    title: mealPewview.strMeal,
                    url: URL(string: mealsViewModel.selectedMeal?.strSource ?? "")
                )
                    .padding(.horizontal)
                if let meal = mealsViewModel.selectedMeal {
                    MealDetailsIngredientsView(selectedMeal: meal)
                    .padding()
                }
                Text((mealsViewModel.selectedMeal?.strInstructions ?? "").replacingOccurrences(of: "\n", with: "\n\n"))
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .padding(.horizontal)
            .toolbar(.hidden)
            .onAppear {
                mealsViewModel.fetchMealById(mealPewview.idMeal)
            }
            .task {
                let myMeal = await favotiesViewModel.fetchMealById(mealPewview.idMeal)
                if myMeal != nil {
                    isFavorite = true
                }
            }
        }
    }
}

struct DetailsMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsScreen(mealPewview: MealPreview(strMeal: "Beef with salt", strMealThumb: "https://www.themealdb.com/images/media/meals/1520081754.jpg", idMeal: "52942"))
    }
}
