//
//  MainView.swift
//  RecipesApp
//
//  Created by andres paladines on 8/16/23.
//

import Foundation
import SwiftUI

struct MainPageView: View {

    @EnvironmentObject var coordinator: MainCoordinator
    @AppStorage(UserDefaultsKeys.isUserLogged.rawValue) var logStatus: Bool = false

    var body: some View {
        NavigationStack(path: $coordinator.path) {
//            if logStatus {
//                coordinator.getPage(.tabBarView)
//                    .navigationDestination(for: MainPath.self) { page in
//                        coordinator.getPage(page)
//                    }
//            }else {
                coordinator.getPage(.login)
                    .navigationDestination(for: MainPath.self) { page in
                        coordinator.getPage(page)
                    }
//            }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
            .environmentObject(MainCoordinator())
    }
}
