//
//  MainListScreen.swift
//  RecipesApp
//
//  Created by Consultant on 8/17/23.
//

import SwiftUI

struct MainListScreen: View {

    @ObservedObject var mealsViewModel = MealsViewModel(networkManager: NetworkManager())

    var body: some View {
        VStack {
            HeaderBarView(title: "Meals", letftButtonHidden: true, rightButtonHidden: true)
            if mealsViewModel.mealsFilterResponseList.isNotEmpty {
                if mealsViewModel.mealsFilterResponseList.indices.contains(0) {
                    generateListOf(
                        mealsViewModel.mealsFilterResponseList[0].meals,
                        with: mealsViewModel.mealsFilterResponseList[0].strCategory ?? "No category name"
                    )
                }
                if mealsViewModel.mealsFilterResponseList.indices.contains(1) {
                    generateListOf(
                        mealsViewModel.mealsFilterResponseList[1].meals,
                        with: mealsViewModel.mealsFilterResponseList[1].strCategory ?? "No category name"
                    )
                }
                if mealsViewModel.mealsFilterResponseList.indices.contains(2) {
                    generateListOf(
                        mealsViewModel.mealsFilterResponseList[2].meals,
                        with: mealsViewModel.mealsFilterResponseList[2].strCategory ?? "No category name"
                    )
                }
            }else {
                VStack(alignment: .center) {
                    Spacer()
                    Image("no-data-found")
                        .resizable()
                        .frame(width: 128, height: 100)
                        .cornerRadius(25, corners: .topLeft)
                        .cornerRadius(25, corners: .bottomRight)
                    Text("To show a list of meals, select at least one category in the application settings.")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding([.bottom], 20)
                    Spacer()
                }
            }


        }
        .onAppear {
            mealsViewModel.fetchDataFromMultipleAPIs(["Beef", "Dessert", "Pasta"])
//            mealsViewModel.getListOf([.area,.categories])
//            mealsViewModel.getCategories()
        }
    }

    @ViewBuilder
    func generateListOf(_ meals: [MealPreview], with header: String) -> some View {
        List {
            SectionHeader(leftText: header, rightText: "")
            ForEach(meals) { meal in
                Text(meal.strMeal)
                    .font(.body)
            }
        }
    }
}

struct MainListScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainListScreen()
    }
}
