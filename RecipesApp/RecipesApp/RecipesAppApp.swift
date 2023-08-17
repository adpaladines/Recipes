//
//  RecipesAppApp.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/9/23.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct RecipesAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

//    init() { setupAuthentication() }

    var body: some Scene {
        WindowGroup {
            MainPageView()
                .environmentObject(MainCoordinator())
            
//            ContentView()
////            LoginView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }

//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        return .noData
    }
}

//extension RecipesAppApp {
//
//  private func setupAuthentication() {
//    FirebaseApp.configure()
//  }
//
//}
