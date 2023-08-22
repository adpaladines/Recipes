//
//  GenericCoreDataManager.swift
//  RememberMe
//
//  Created by Andres D. Paladines on 7/28/23.
//

import Foundation
import CoreData

class GenericPersistenceManager: CoreDataOperationsProtocol {
    
    typealias ItemType = Meal
    var context: NSManagedObjectContext
    
    required init(context: NSManagedObjectContext) {
        self.context = context
    }

    func clearData<T: NSManagedObject>(entityType: T.Type) async throws {
        guard let entityName = T.entity().name else {
            throw NSError(domain: "Invalid entity name", code: 0, userInfo: nil)
        }
        try await context.perform {
            let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
            let results = try self.context.fetch(request)
            results.forEach { entity in
                self.context.delete(entity)
            }
            try self.context.save()
        }
    }

}
