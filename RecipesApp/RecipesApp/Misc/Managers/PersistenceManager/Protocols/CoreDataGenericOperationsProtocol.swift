//
//  CoreDataGenericOperationsProtocol.swift
//  RememberMe
//
//  Created by Andres D. Paladines on 7/28/23.
//

import Foundation
import CoreData

protocol CoreDataGenericOperationsProtocol {

    var context: NSManagedObjectContext { get }
    
    init(context: NSManagedObjectContext)
    
    func clearData<T: NSManagedObject>(entityType: T.Type) async throws

}
