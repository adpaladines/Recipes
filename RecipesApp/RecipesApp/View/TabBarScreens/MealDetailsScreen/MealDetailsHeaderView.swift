//
//  HeaderBarView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/17/23.
//

import SwiftUI

struct MealDetailsHeaderView: View {

    @AppStorage(UserDefaultsKeys.isUserLogged.rawValue) var logStatus: Bool = false
    
    @EnvironmentObject var coordinator: MainCoordinator
    
    @StateObject var favoriteMealsViewModel = FavoriteMealsViewModel()
    
    var title: String
    var selectedMeal: Meal?
    
    var letftButtonHidden: Bool = false
    var rightButtonHidden: Bool = false
    
    @Binding var isFavorite: Bool
    @State var isAlertPresent: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                if !letftButtonHidden {
                    Button {
                        coordinator.path.removeLast()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .padding()
                            .imageScale(.large)
                            .frame(width: 36, height: 36)
                    }
                    .foregroundColor(Color(uiColor: .darkGray))
                }
                Spacer()
                if !rightButtonHidden {
                    Button {
                        if let newMeal = selectedMeal {
                            print(newMeal.idMeal)
//                            Task {
//                                if isFavorite {
//                                    await favoriteMealsViewModel.add(new: newMeal)
//                                }else {
//                                    await favoriteMealsViewModel.delete(meal: newMeal)
//                                }
//                            }
                        }
                        withAnimation(.easeInOut) {
                            isAlertPresent = true
                            isFavorite.toggle()
                        }
                    } label: {
                        Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .frame(width: 24, height: 30)
                            .foregroundColor(isFavorite ? .red : .gray)
                    }
                    .foregroundColor(Color(uiColor: .darkGray))
                    .frame(width: 36, height: 48)
                }
            }
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
            
        }
        .padding([.horizontal])
//        .alert(isPresented: $isAlertPresent) {
//            Alert(
//                title: Text("Bookmark"),
//                message: Text(isFavorite ? "Added to your favorites." : "Deleted from your favorites."),
//                dismissButton: Alert.Button.default(Text("Ok"))
//            )
//        }
        .onChange(of: isFavorite) { newValue in
            Task {
                guard let newMeal = selectedMeal, isAlertPresent else {
                    return
                }
                if newValue {
                    await favoriteMealsViewModel.add(new: newMeal)
                }else {
                    await favoriteMealsViewModel.delete(meal: newMeal)
                }
            }
        }
    }
}

struct HeaderBarView_Previews: PreviewProvider {

    static var previews: some View {
        MealDetailsHeaderView(title: "Beef with salt", isFavorite: .constant(true))
            .environmentObject(MainCoordinator())
    }
}
