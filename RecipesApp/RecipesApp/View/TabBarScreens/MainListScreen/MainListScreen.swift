//
//  MainListScreen.swift
//  RecipesApp
//
//  Created by Consultant on 8/17/23.
//

import SwiftUI
import Kingfisher

struct GridMeals: View {
    
    @StateObject var mealsViewModel: MealsViewModel
    
    var category: String
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(mealsViewModel.prefOneMealPreviewsList) { meal in
                        MealPreviewCellView(mealPreview: meal, category: category)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.1), radius: 10)
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

struct MainListScreen: View {
    @AppStorage(UserDefaultsKeys.preferredCategories.rawValue) private var preferredCategories = "[]"
    
    @EnvironmentObject var orientationInfo: OrientationInfo
    
    @StateObject var mealsViewModel = MealsViewModel(networkManager: NetworkManager())
    @StateObject var categoriesViewModel = CategoriesViewModel(networkManager: NetworkManager())
    
    
    @State var typeSelected: String = "Beef"
    
    var body: some View {
        VStack {
//            HeaderBarView(title: "Meals", letftButtonHidden: true, rightButtonHidden: false)
            MainHeaderBar(title: "Hi Andres", notifications: 1)
                .padding(.horizontal)
                .padding(.top, 8)
            FilterToolBar(categoriesViewModel: categoriesViewModel, typeSelected: $typeSelected)
                .padding([.bottom], orientationInfo.orientation == .portrait ? 16 : 0)
                .padding([.top], 0)
                .padding([.horizontal])
                .frame(height: 64)
            
            VStack(alignment: .center) {
                if mealsViewModel.prefOneMealPreviewsList.isNotEmpty {
                    Text(typeSelected)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                GridMeals(mealsViewModel: mealsViewModel, category: typeSelected)
            }
        }
        .toolbar(.hidden)
    }

    
}

struct MainListScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainListScreen()
            .environmentObject(OrientationInfo())
    }
}
