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
    
    var body: some Scene {
        WindowGroup {
            if  UIDevice.current.isJailBroken {
                MainJailbreakView()
                    .environmentObject(MainCoordinator())
            }else {
                MainPageView()
                    .environmentObject(MainCoordinator())
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        return .noData
    }
}

