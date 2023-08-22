//
//  GridMealsView.swift
//  RecipesApp
//
//  Created by andres paladines on 8/22/23.
//

import SwiftUI

struct GridMealsView: View {
    @StateObject var mealsViewModel: MealsViewModel
    
    var category: String
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(mealsViewModel.prefOneMealPreviewsList) { meal in
                        MealPreviewCellView(mealPreview: meal, category: category)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 10)
                            .frame(width: 320, alignment: .center)
                    }
                }
            }
        .onAppear {
            mealsViewModel.fetchPreviewMealsFromAPI(category)
        }
        .onChange(of: category) { newValue in
            print("category selected: \(newValue)")
            mealsViewModel.fetchPreviewMealsFromAPI(newValue)
        }
    }
}

struct GridMealsView_Previews: PreviewProvider {
    static var previews: some View {
        GridMealsView(mealsViewModel: MealsViewModel(networkManager: NetworkManager()), category: "Category")
    }
}
