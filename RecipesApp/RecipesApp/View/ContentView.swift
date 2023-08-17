//
//  ContentView.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/9/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    @AppStorage(UserDefaultsKeys.isUserLogged.rawValue) var logStatus: Bool = false

    var body: some View {
        if logStatus {
            DemoHome()
        } else {
            LoginView()
        }
    }

    @ViewBuilder
    func DemoHome() -> some View {
        NavigationStack {
            Text("Logged In!")
                .navigationTitle("Googele Login")
                .toolbar {
                    ToolbarItem {
                        Button("Logout") {
                            try? Auth.auth().signOut()
                            GIDSignIn.sharedInstance.signOut()
                            withAnimation(.easeInOut) { logStatus = false }
                        }
                    }
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
