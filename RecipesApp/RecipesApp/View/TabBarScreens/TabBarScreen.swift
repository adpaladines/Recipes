//
//  TabBarView.swift
//  RecipesApp
//
//  Created by Consultant on 8/17/23.
//

import SwiftUI

struct TabBarScreen: View {

    @AppStorage(UserDefaultsKeys.preferredCategories.rawValue) private var preferredCategories = "[]"
    @AppStorage(UserDefaultsKeys.notShowAgainPreferredCategoriesPupop.rawValue) private var notShowAgain = false
    @State var presentingModal: Bool
    @State var popupShown: Bool = false

    var body: some View {
        TabView() {
            MainListScreen()
                .environmentObject(OrientationInfo())
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            FavoritesListScreen()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Favorites")
                }
        }
        .fullScreenCover(
            isPresented: $presentingModal,
            onDismiss: {
                print("RETURNED FROM POPUP")
            }, content: {
                ModalView(presentedAsModal: self.$presentingModal)
            })
        .onAppear {
            guard !popupShown && !notShowAgain else {
                return
            }
            if let decodedArray = [String](rawValue: preferredCategories), decodedArray.isNotEmpty {
                presentingModal = false
            }else {
                presentingModal = true
            }
            self.popupShown = true
        }
    }
}

struct TabBarScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabBarScreen(presentingModal: false)
    }
}
