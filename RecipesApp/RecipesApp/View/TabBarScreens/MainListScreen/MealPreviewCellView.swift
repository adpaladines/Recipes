//
//  MealPreviewCellView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/21/23.
//

import SwiftUI
import Kingfisher

struct MealPreviewCellView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    var mealPreview: MealPreview
    var category: String = ""
    var cornerRadius: Double = 12
    
    @State var isLoading = true
    @State var hasError = false
    @State var isFavorite: Bool = false
    @State var placeHolderImage: String = "meal-placeholder"
    
    @ViewBuilder
    func presentPlaceHolder() -> some View {
        Image(placeHolderImage)
            .resizable()
            .scaledToFit()
            .frame(height: 146)
            .frame(maxWidth: .infinity, alignment: .center)
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.3), radius: 5)
            .padding(.top)
    }
    
    @ViewBuilder
    func presentErrorImage() -> some View {
        HStack {
            Spacer()
            Text(category.isEmpty ? "Without category": category)
                .font(Font.system(.body))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 1)
                .padding(.horizontal, 8)
                .background(.green)
                .cornerRadius(cornerRadius, corners: .topRight)
                .cornerRadius(cornerRadius, corners: .bottomLeft)
                .padding(.top)
        }
        .padding(.top, 0)
        .padding(.horizontal, 0)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                if let url = URL(string: mealPreview.strMealThumbPreview), !hasError {
                    KFImage.url(url)
                        .onSuccess { r in
                            isLoading = false
                            hasError = false
                        }
                        .placeholder { p in
                            ZStack(alignment: .center) {
                                Image(placeHolderImage)
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                        }
                        .onFailure({ error in
                            isLoading = false
                            hasError = true
                            placeHolderImage = "no-data-found-wide"
                        })
                        .resizable()
                        .scaledToFill()
                        .frame(height: 146)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .cornerRadius(cornerRadius)
                        .shadow(color: .black.opacity(0.3), radius: 5)
                        .padding(.top)
                }else  {
                    presentPlaceHolder()
                }
                if !hasError {
                    presentErrorImage()
                }
                
                if isFavorite {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image(systemName: isFavorite ? "bookmark.fill": "bookmark" )
                                .resizable()
                                .frame(width: 24, height: 28)
                                .foregroundColor(isFavorite ? .green : .white)
                                .padding([.horizontal, .top], 4)
                                .padding(.bottom, 2)
                                .background(isFavorite ? .white : .clear)
                                .cornerRadius(cornerRadius)
                        }
                    }
                    .frame(height: 146)
                    .padding(.trailing)
                }
                
            }
            .padding(.horizontal)
            HStack {
                Text(mealPreview.strMeal)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black.opacity(0.75))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom)
            }
        }
        .background(.white)
//        .frame(width: 320, height: 250)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black.opacity(0.07), lineWidth: 2)
        )
        .onTapGesture {
            coordinator.goTo(.mealDetails(meal: mealPreview))
        }
//        onAppear {
//            isPresented = true
//            print(mealPreview.strMeal)
//        }
    }
}

struct MealPreviewCellView_Previews: PreviewProvider {
    static var previews: some View {
        MealPreviewCellView(
            mealPreview:
                MealPreview(
                    strMeal: "Baked salmon",
                    strMealThumb: "https://www.themealdb.com/images/media/meals/1548772327.jpg",
                    idMeal: "52959"
                ),
            isFavorite: false
        )
        .environmentObject(MainCoordinator())
    }
}

