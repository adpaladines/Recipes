//
//  CoreDataOperationsProtocol.swift
//  RememberMe
//
//  Created by Andres D. Paladines on 7/28/23.
//

import Foundation
import CoreData

protocol CoreDataOperationsProtocol {
    
    var context: NSManagedObjectContext { get }
    
    init(context: NSManagedObjectContext)
    
//    func saveDataIntoDatabase<ItemType>(items: ItemType, type: ItemType.Type) async throws

}

