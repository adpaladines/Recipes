//
//  MainListScreen.swift
//  RecipesApp
//
//  Created by Consultant on 8/17/23.
//

import SwiftUI
import Kingfisher

struct MealPreviewCellView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    var mealPreview: MealPreview
    var category: String = ""
    var cornerRadius: Double = 12
    
    @Binding var isPresented: Bool
    @State var isLoading = true
    @State var hasError = false
    @State var isFavorite: Bool = false
    @State var placeHolderImage: String = "meal-placeholder"
    
    @ViewBuilder
    func presentPlaceHolder() -> some View {
        Image(placeHolderImage)
            .resizable()
            .scaledToFill()
            .frame(height: 146)
            .frame(width: 320 )
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.3), radius: 5)
            .background(.black)
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
                if let url = URL(string: mealPreview.strMealThumbPreview), !hasError{//}, isPresented {
                    
//                    KFImage.url(url)
//                        .onSuccess { r in
//                            print(r)
//                            isLoading = false
//                            hasError = false
//                            print("IMAGE LOAD SUCCESS")
//                        }
//                        .placeholder { p in
//                            ZStack(alignment: .center) {
//                                Image(placeHolderImage)
//                                    .resizable()
//                                    .frame(width: 48, height: 48)
//                            }
//                            .task {
//                                print(mealPreview.strMealThumbPreview)
//                            }
//                        }
//                        .onFailure({ error in
//                            isLoading = false
//                            hasError = true
//                            placeHolderImage = "no-data-found-wide"
//                            print("IMAGE LOAD FAIL")
//                        })
//                        .resizable()
//                        .scaledToFill()
//                        .frame(height: 146)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        .cornerRadius(cornerRadius)
//                        .shadow(color: .black.opacity(0.3), radius: 5)
//                        .padding(.top)
                    
                    AsyncImage(url: url, scale: 1.0) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 146)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .cornerRadius(cornerRadius)
                            .shadow(color: .black.opacity(0.3), radius: 5)
                            .padding(.top)
                    } placeholder: {
                        presentPlaceHolder()
                    }.task {
                        print(url)
                    }

                }else  {
                    presentPlaceHolder()
                }
                if !hasError {
                    presentErrorImage()
                }
//                if !isPresented {
//                    presentPlaceHolder()
//                }
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
//            .padding(.top)
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
            isPresented: .constant(true),
            isFavorite: false
        )
        .environmentObject(MainCoordinator())
    }
}


struct GridMeals: View {
    @StateObject var mealsViewModel: MealsViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                if mealsViewModel.prefOneMealPreviewsList.isNotEmpty {
                
                    MealPreviewCellView(mealPreview: mealsViewModel.prefOneMealPreviewsList[0], category: "header", isPresented: .constant(true))
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.1), radius: 10)
                        
                    MealPreviewCellView(mealPreview: mealsViewModel.prefOneMealPreviewsList[1], category: "header_2", isPresented: .constant(true))
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.1), radius: 10)
                        
                
                    
                //                            ForEach(mealsViewModel.prefOneMealPreviewsList, id: \.id) { meal in
                //                                MealPreviewCellView(mealPreview: meal, category: "", isPresented: .constant(true))
                //                                    .cornerRadius(20)
                //                                    .shadow(color: .black.opacity(0.1), radius: 10)
                //                            }
                    
                    
//                                ForEach(mealsViewModel.prefOneMealPreviewsList, id: \.id) { meal in
//                                    AsyncImage(url: URL(string: meal.strMealThumb)) {
//                                        image in
//                                        image
//                                            .resizable()
//                                            .frame(height: 24)
//                                    } placeholder: {
//                                        Image("meal-placeholder")
//                                            .resizable()
//                                            .frame(height: 24)
//                                    }
//                                }
//                                .frame(width: 320, height: 250)
//                .frame(width: 24, height: 24, alignment: .center)
                
            }
            }
        }
        .frame(height: 250)
        .onAppear {
            mealsViewModel.fetchPreviewMealsFromAPIs(["Beef"], for: .one)
        }
    }
}

struct MainListScreen: View {
    @EnvironmentObject var orientationInfo: OrientationInfo
    @StateObject var mealsViewModel = MealsViewModel(networkManager: NetworkManager())
    @StateObject var categoriesViewModel = CategoriesViewModel(networkManager: NetworkManager())
    @State var typeSelected: String = ""
    
    var body: some View {
        VStack {
//            HeaderBarView(title: "Meals", letftButtonHidden: true, rightButtonHidden: false)
            MainHeaderBar(title: "Hi Andres", notifications: 1)
                .padding(.horizontal)
            FilterToolBar(categoriesViewModel: categoriesViewModel, typeSelected: $typeSelected)
                .padding([.bottom], orientationInfo.orientation == .portrait ? 16 : 0)
                .padding([.top], 0)
                .padding([.horizontal])
            
            GridMeals(mealsViewModel: mealsViewModel)
            
            if mealsViewModel.prefOneMealPreviewsList.isNotEmpty {
//                if mealsViewModel.mealsFilterResponseList.indices.contains(0) {
//                    generateListOf(
//                        index: 0
//                    )
                    
                    
//                }
//                if mealsViewModel.mealsFilterResponseList.indices.contains(1) {
//                    generateListOf(
//                        index: 1
//                    )
//                }
//                if mealsViewModel.mealsFilterResponseList.indices.contains(2) {
//                    generateListOf(
//                        index: 2
//
//                    )
//                }
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
            Spacer()
        }
        .onAppear {
//            mealsViewModel.fetchPreviewMealsFromAPIs(["Beef"])///, "Dessert", "Pasta"])
//            mealsViewModel.fetchPreviewMealsFromAPIs(["Beef"], for: .one)
//            mealsViewModel.fetchPreviewMealsFromAPIs(["Beef"], for: .two)
//            mealsViewModel.fetchPreviewMealsFromAPIs(["Beef"], for: .three)

        }
        .toolbar(.hidden)
    }

    @ViewBuilder
    func generateListOf(index: Int) -> some View {
        let rows = [GridItem(.flexible())]
        
        VStack {
            SectionHeader(leftText: "asd", rightText: "")
            
//            ScrollView(.horizontal, showsIndicators: false) {
//                LazyHGrid(rows: [GridItem(.flexible())], alignment: .center, spacing: 16) {
//                    ForEach(meals, id: \.self.id) { meal in
//                        MealPreviewCellView(mealPreview: meals[0], category: header, isPresented: .constant(true))
//                            .cornerRadius(20)
//                            .shadow(color: .black.opacity(0.1), radius: 10)
//                    }
//                }
//            }
            
            
            ScrollView() {
                LazyHGrid(rows: rows) {
//                    MealPreviewCellView(mealPreview: meals[0], category: header, isPresented: .constant(true))
//                        .cornerRadius(20)
//                        .shadow(color: .black.opacity(0.1), radius: 10)
//                    MealPreviewCellView(mealPreview: meals[1], category: header, isPresented: .constant(true))


//                    ForEach(mealsViewModel.mealsFilterResponseList[index].meals, id: \.id) { meal in
//
//                        MealPreviewCellView(mealPreview: meal, category: mealsViewModel.mealsFilterResponseList[index].strCategory ?? "N/A", isPresented: .constant(true))
//                            .cornerRadius(20)
//                            .shadow(color: .black.opacity(0.1), radius: 10)
//                    }
                }
            }
            .frame(height: 250)
        }
        
        
    }

    
}

struct MainListScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainListScreen()
            .environmentObject(OrientationInfo())
    }
}
