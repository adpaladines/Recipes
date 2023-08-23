//
//  MainListScreen.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/17/23.
//

import SwiftUI

struct MainListScreen: View {
    
    @EnvironmentObject var orientationInfo: OrientationInfo
    @StateObject var mealsViewModel = MealsViewModel(networkManager: NetworkManager())
    @StateObject var categoriesViewModel = CategoriesViewModel(networkManager: NetworkManager())
    
    @State var typeSelected: String = "Beef"
    
    var body: some View {
        VStack {
            MainHeaderBar(categories: categoriesViewModel.categoriesListFiltered, title: "Hi Andres", notifications: 1)
                .padding(.top, 8)
                .padding(.horizontal)
            
            FilterToolBar(categoriesViewModel: categoriesViewModel, typeSelected: $typeSelected)
                .padding([.bottom], orientationInfo.orientation == .portrait ? 16 : 0)
                .padding([.top], 0)
                .frame(height: 64)
            
            VStack(alignment: .center) {
                if mealsViewModel.prefOneMealPreviewsList.isNotEmpty {
                    Text(typeSelected)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
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

struct MainListScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainListScreen()
            .environmentObject(OrientationInfo())
    }
}
