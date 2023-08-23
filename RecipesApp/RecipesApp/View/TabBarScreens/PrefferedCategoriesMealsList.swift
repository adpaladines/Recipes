//
//  PrefferedCategoriesMealsList.swift
//  RecipesApp
//
//  Created by andres paladines on 8/23/23.
//

import SwiftUI

struct MyCategoriesListScreen: View {
    let categories: [Category]
    let listTitle: String
    
    var body: some View {
        VStack {
            MainHeaderBar(title: "Hi Andres", notifications: 1)
                .padding(.horizontal)
            List(categories) { meal in
                NavigationLink(destination: MealDetailScreen(meal: meal)) {
                    MealRowView(meal: meal)
                }
            }
        }
        .toolbar(.hidden)
    }
}

struct MealRowView: View {
    let meal: Category
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.green)
                .background(Color.white)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(meal.strCategory)
                    .font(.headline)
                
                Text(meal.strCategoryDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
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
            Category(idCategory: "1", strCategory: "Cat 1", strCategoryThumb: "imageURL1", strCategoryDescription: "Category description 1"),
            Category(idCategory: "2", strCategory: "Cat 2", strCategoryThumb: "imageURL1", strCategoryDescription: "Category description 2"),
            Category(idCategory: "3", strCategory: "Cat 3", strCategoryThumb: "imageURL1", strCategoryDescription: "Category description 3")
        ]
        
        NavigationView {
            MyCategoriesListScreen(categories: cats, listTitle: "My preferred categories")
        }
    }
}
