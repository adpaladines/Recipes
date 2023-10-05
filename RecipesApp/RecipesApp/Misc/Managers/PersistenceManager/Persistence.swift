//
//  Persistence.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/9/23.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RecipesPersistence")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        
        
        let protectionOptions = [NSPersistentStoreFileProtectionKey: FileProtectionType.completeUntilFirstUserAuthentication]
        guard let storeCoordinator = container.persistentStoreCoordinator.persistentStores.first else {
            print("NO DATABASE SECURITY SET")
            return
        }
        container.persistentStoreCoordinator.setMetadata(protectionOptions, for: storeCoordinator)
    }
}
