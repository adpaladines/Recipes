//
//  TabBarView.swift
//  RecipesApp
//
//  Created by Consultant on 8/17/23.
//

import SwiftUI

struct TabBarScreen: View {
    var body: some View {
        TabView() {
            MainListScreen()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
        }
    }
}

struct TabBarScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabBarScreen()
    }
}
