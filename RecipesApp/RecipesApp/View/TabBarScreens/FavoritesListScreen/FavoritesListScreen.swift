//
//  FavoritesListScreen.swift
//  RecipesApp
//
//  Created by andres paladines on 8/21/23.
//

import SwiftUI
import Kingfisher

struct FavoritesGridMeals: View {
    
    @StateObject var favoriteMealsViewModel: FavoriteMealsViewModel
    
    var category: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                if favoriteMealsViewModel.customError == nil {
                    ForEach(favoriteMealsViewModel.mealsListFiltered, id: \.id) { meal in
                        MealPreviewCellView(mealPreview: MealPreview(strMeal: meal.strMeal, strMealThumb: meal.strMealThumb, idMeal: meal.idMeal), category: category)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.1), radius: 10)
                            .frame(width: 320, alignment: .center)
                    }
                }else {
                    
                }
            }
        }
        .onAppear {
            Task {
                await favoriteMealsViewModel.fetchMealsListFromDB()
            }
        }
    }
}

struct FavoritesListScreen: View {
    
    @StateObject var favoriteMealsViewModel = FavoriteMealsViewModel()
    
    @State var typeSelected: String = "Beef"
    
    var body: some View {
        VStack {
            //            HeaderBarView(title: "Meals", letftButtonHidden: true, rightButtonHidden: false)
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
