//
//  FavoritesListScreen.swift
//  RecipesApp
//
//  Created by andres paladines on 8/21/23.
//

import SwiftUI
import Kingfisher

struct FavoritesGridMeals: View {
    
    @ObservedObject var favoriteMealsViewModel: FavoriteMealsViewModel
    
    var category: String
    
    var body: some View {
        VStack {
            if favoriteMealsViewModel.customError == nil {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(favoriteMealsViewModel.mealsListFiltered) { meal in
                            MealPreviewCellView(mealPreview: MealPreview(strMeal: meal.strMeal, strMealThumb: meal.strMealThumb, idMeal: meal.idMeal), category: category)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.1), radius: 10)
                                .frame(width: 320, alignment: .center)
                        }
                        
                    }
                }
            }else {
                VStack {
                    Spacer()
                    Image("no-data-found-wide")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 146)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.3), radius: 5)
                        .padding(.top)
                    Text("Add meals to your bookmarks to watch them here!")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
        }
        .task {
            await favoriteMealsViewModel.fetchMealsListFromDB()
        }
    }
}

struct FavoritesListScreen: View {
    
    @StateObject var favoriteMealsViewModel = FavoriteMealsViewModel()
    
    @State var typeSelected: String = "My Favorute Meals"
    
    var body: some View {
        VStack {
            MainHeaderBar(title: "Hi Andres", notifications: 1)
                .padding(.horizontal)
                .padding(.top, 8)
                VStack(alignment: .center) {
                    Text(typeSelected)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    FavoritesGridMeals(favoriteMealsViewModel: favoriteMealsViewModel, category: typeSelected)
                }
                .padding()
            Spacer()
        }
        .toolbar(.hidden)
    }
    
}

struct FavoritesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListScreen()
            .environmentObject(OrientationInfo())
    }
}
