//
//  MainJailbreakView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/16/23.
//
import Foundation
import SwiftUI

struct MainJailbreakView: View {

    @EnvironmentObject var coordinator: MainCoordinator
    @AppStorage(UserDefaultsKeys.isUserLogged.rawValue) var logStatus: Bool = false

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getPage(.jailBreakScreen)
                .navigationDestination(for: MainPath.self) { page in
                    coordinator.getPage(page)
                }
        }
    }
}

struct MainJailbreakView_Previews: PreviewProvider {
    static var previews: some View {
        MainJailbreakView()
            .environmentObject(MainCoordinator())
    }
}
