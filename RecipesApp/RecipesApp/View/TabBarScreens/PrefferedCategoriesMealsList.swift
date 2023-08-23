//
//  PrefferedCategoriesMealsList.swift
//  RecipesApp
//
//  Created by andres paladines on 8/23/23.
//

import SwiftUI

struct MyCategoriesListScreen: View {
    
    @AppStorage(UserDefaultsKeys.preferredCategories.rawValue) private var preferredCategories = "[]"
    
    @EnvironmentObject var coordinator: MainCoordinator

    @State var categories: [Category]
    let listTitle: String
    
    var body: some View {
        VStack {
            CommonHeaderBar(title: "My categories")
                .padding(.horizontal)
            List(categories) { meal in
//                NavigationLink(destination: MealDetailScreen(meal: meal)) {
//                    MealRowView(meal: meal)
//                }
                Button {
                    coordinator.goTo(.mealsByPreferredCategoryScreen(title: meal.strCategory, category: meal.strCategory))
                }label: {
                    MealRowView(meal: meal)
                }
            }
        }
        .toolbar(.hidden)
        .onAppear {
            guard let decodedArray = [String](rawValue: preferredCategories), decodedArray.isNotEmpty else {
                return
            }
            categories = categories.filter({ cat in
                decodedArray.contains(cat.strCategory)
            })
        }
    }
}

struct MealRowView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    let meal: Category
    
    var body: some View {
        HStack(spacing: 16) {
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(meal.strCategory)
                    .font(.title2)
                
                AsyncImage(url: URL(string: meal.strCategoryThumb)) {
                    image in
                        image
                        .resizable()
                        .frame(width: .infinity, height: 50)
                        .foregroundColor(.green)
                        .background(Color.white)
                        .clipShape(Circle())
                } placeholder: {
                    Image("meal-placeholder")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .frame(width: 50, height: 50, alignment: .center)
                .padding(.bottom)
                
                
                Text(meal.strCategoryDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Button {
                    coordinator.goTo(.mealsByPreferredCategoryScreen(title: meal.strCategory, category: meal.strCategory))
                }label: {
                    Text("")
                }
            }
        }
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(10)
//        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

struct MealDetailScreen: View {
    let meal: Category
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .foregroundColor(.green)
            
            Text(meal.strCategory)
                .font(.title)
            Text(meal.strCategoryDescription)
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(meal.strCategory)
    }
}


struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        let cats: [Category] = [
            Category(idCategory: "1", strCategory: "Cat 1", strCategoryThumb: "imageURL1", strCategoryDescription: "Category description 1Category description 1Category description 1Category description 1Category description 1Category description 1Category description 1Category description 1Category description 1Category description 1"),
            Category(idCategory: "2", strCategory: "Cat 2", strCategoryThumb: "imageURL1", strCategoryDescription: "Category description 2Category description 2Category description 2Category description 2Category description 2Category description 2Category description 2Category description 2Category description 2Category description 2"),
            Category(idCategory: "3", strCategory: "Cat 3", strCategoryThumb: "imageURL1", strCategoryDescription: "Category description 3")
        ]
        
        NavigationView {
            MyCategoriesListScreen(categories: cats, listTitle: "My preferred categories")
                .environmentObject(MainCoordinator())
        }
    }
}
