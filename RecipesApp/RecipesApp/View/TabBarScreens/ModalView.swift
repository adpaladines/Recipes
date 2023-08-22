//
//  ModalView.swift
//  RecipesApp
//
//  Created by Consultant on 8/18/23.
//

import SwiftUI

struct ModalView: View {
    @Binding var presentedAsModal: Bool
    @AppStorage(UserDefaultsKeys.notShowAgainPreferredCategoriesPupop.rawValue) private var notShowAgain = false
    @AppStorage(UserDefaultsKeys.preferredCategories.rawValue) private var preferredCategories = "[]"
    
    @StateObject var categoriesViewModel = CategoriesViewModel(networkManager: NetworkManager())
    
    @State var isOn: Bool = false
    @State var alertMaxFavorites: Bool = false
//    @State var categories: [Category] = []
    @State var favoriteCategories: [Category] = []
    var body: some View {
            VStack {
                Text("Select three categories as your favorites.")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Button("dismiss") {
                    self.presentedAsModal = false
                }
                Toggle(isOn: $isOn) {
                    Text("I'm not a robot")
                }
                .toggleStyle(iOSCheckboxToggleStyle())
                .shadow(radius: 1)
                List {
                    ForEach(categoriesViewModel.categoriesListFiltered) { category in
                        HStack {
                            AsyncImage(url: URL(string: category.strCategoryThumb)) {
                                image in
                                    image
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            } placeholder: {
                                Image("meal-placeholder")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
//                            .frame(width: 24, height: 24, alignment: .center)
                            Text(category.strCategory)
                            Spacer()
                            Button {
                                
                                if let index = favoriteCategories.firstIndex(where: {$0.idCategory == category.idCategory}) {
                                    favoriteCategories.remove(at: index)
                                }else {
                                    guard favoriteCategories.count < 3 else {
                                        alertMaxFavorites = true
                                        return
                                    }
                                    favoriteCategories.append(category)
                                }
                            }label: {
                                if (favoriteCategories.first(where: {$0.idCategory == category.idCategory}) != nil) {
                                    Image(systemName: "checkmark.square")
                                }else {
                                    Image(systemName: "square")
                                }
                                
                            }
                        }
                        
                    }
                }
            }
            .onChange(of: isOn) { newValue in
                print("Not show again: \(newValue)")
                notShowAgain = newValue
            }
            .onChange(of: favoriteCategories.count, perform: { newValue in
                var catsList = [String]()
                favoriteCategories.forEach { category in
                    catsList.append(category.strCategory)
                }
                preferredCategories = catsList.rawValue
            })
            .alert(isPresented: $alertMaxFavorites) {
                Alert(
                    title: Text("Preferred Categories"),
                    message: Text("You can select a maximum of three categories."),
                    dismissButton: Alert.Button.default(Text("Ok"))
                )
            }
            .onAppear {
                categoriesViewModel.fetchAllCategories()
            }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(
            presentedAsModal: .constant(false)//,
//            categories: [
//                Category(idCategory: "1692683131", strCategory: "Beef", strCategoryThumb: "https://www.themealdb.com/images/category/beef.png", strCategoryDescription: "Description"),
//                Category(idCategory: "1692683143", strCategory: "Lamb", strCategoryThumb: "https://www.themealdb.com/images/category/lamb.png", strCategoryDescription: "Description"),
//                Category(idCategory: "1692683145", strCategory: "Pasta", strCategoryThumb: "https://www.themealdb.com/images/category/pasta.png", strCategoryDescription: "Description"),
//                Category(idCategory: "16926833455", strCategory: "Pasta", strCategoryThumb: "https://www.themealdb.com/images/category/pasta.png", strCategoryDescription: "Description"),
//                Category(idCategory: "1467683145", strCategory: "Pasta", strCategoryThumb: "https://www.themealdb.com/images/category/pasta.png", strCategoryDescription: "Description")
//
//            ]
        )
    }
}
