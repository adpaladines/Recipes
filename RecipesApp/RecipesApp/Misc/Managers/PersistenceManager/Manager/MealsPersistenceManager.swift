//
//  MealsPersistenceManager.swift
//  RememberMe
//
//  Created by Andres D. Paladines on 7/28/23.
//

import Foundation
import CoreData

class MealsPersistenceManager: CoreDataOperationsProtocol {

    typealias ItemType = [Meal]
    
    let context: NSManagedObjectContext
    
    required init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchSingleItemFromDatabase(idMeal: String) async throws -> MealEntity? {
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        let predicate = NSPredicate(format: "idMeal == %@", idMeal)
        fetchRequest.predicate = predicate
        let result = try context.fetch(fetchRequest).first
        return result
    }
    
    func fetchDataFromDatabase() async throws -> [MealEntity] {
        let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        let result = try context.fetch(request)
        return result
    }
    
    func getFirstItemDataFromDatabase() async throws -> MealEntity? {
        let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        let result = try context.fetch(request).first
        return result
    }

    func saveDataIntoDatabase(item: Meal) async throws {
        let mealEntity = MealEntity(context: context)
            mealEntity.idMeal = item.idMeal
            mealEntity.strMeal = item.strMeal
            mealEntity.strDrinkAlternate = item.strDrinkAlternate
            mealEntity.strCategory = item.strCategory
            mealEntity.strArea = item.strArea
            mealEntity.strInstructions = item.strInstructions
            mealEntity.strMealThumb = item.strMealThumb
            mealEntity.strTags = item.strTags
            mealEntity.strYoutube = item.strYoutube
            mealEntity.strIngredient1 = item.strIngredient1
            mealEntity.strIngredient2 = item.strIngredient2
            mealEntity.strIngredient3 = item.strIngredient3
            mealEntity.strIngredient4 = item.strIngredient4
            mealEntity.strIngredient5 = item.strIngredient5
            mealEntity.strIngredient6 = item.strIngredient6
            mealEntity.strIngredient7 = item.strIngredient7
            mealEntity.strIngredient8 = item.strIngredient8
            mealEntity.strIngredient9 = item.strIngredient9
            mealEntity.strIngredient10 = item.strIngredient10
            mealEntity.strIngredient11 = item.strIngredient11
            mealEntity.strIngredient12 = item.strIngredient12
            mealEntity.strIngredient13 = item.strIngredient13
            mealEntity.strIngredient14 = item.strIngredient14
            mealEntity.strIngredient15 = item.strIngredient15
            mealEntity.strIngredient16 = item.strIngredient16
            mealEntity.strIngredient17 = item.strIngredient17
            mealEntity.strIngredient18 = item.strIngredient18
            mealEntity.strIngredient19 = item.strIngredient19
            mealEntity.strIngredient20 = item.strIngredient20
            mealEntity.strMeasure1 = item.strMeasure1
            mealEntity.strMeasure2 = item.strMeasure2
            mealEntity.strMeasure3 = item.strMeasure3
            mealEntity.strMeasure4 = item.strMeasure4
            mealEntity.strMeasure5 = item.strMeasure5
            mealEntity.strMeasure6 = item.strMeasure6
            mealEntity.strMeasure7 = item.strMeasure7
            mealEntity.strMeasure8 = item.strMeasure8
            mealEntity.strMeasure9 = item.strMeasure9
            mealEntity.strMeasure10 = item.strMeasure10
            mealEntity.strMeasure11 = item.strMeasure11
            mealEntity.strMeasure12 = item.strMeasure12
            mealEntity.strMeasure13 = item.strMeasure13
            mealEntity.strMeasure14 = item.strMeasure14
            mealEntity.strMeasure15 = item.strMeasure15
            mealEntity.strMeasure16 = item.strMeasure16
            mealEntity.strMeasure17 = item.strMeasure17
            mealEntity.strMeasure18 = item.strMeasure18
            mealEntity.strMeasure19 = item.strMeasure19
            mealEntity.strMeasure20 = item.strMeasure20
            mealEntity.strSource = item.strSource
            mealEntity.strImageSource = item.strImageSource
            mealEntity.strCreativeCommonsConfirmed = item.strCreativeCommonsConfirmed
            mealEntity.dateModified = item.dateModified
        do {
            try context.save()
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
//    func updateMealEntity(with uuid: String, titleString: String, bodyString: String) async throws {
//        guard let mealEntity = try await fetchSingleItemFromDatabase(uuid: uuid) else {
//            print("MealEntity with UUID: \(uuid) not found.")
//            return
//        }
//        try context.save()
//    }
    
//    func updateMealEntity(with meal: Meal) async throws {
//        guard let mealEntity = try await fetchSingleItemFromDatabase(idMeal: meal.idMeal) else {
//            print("MealEntity with idMeal: \(meal.idMeal) not found.")
//            return
//        }
//        mealEntity.strMeal = meal.strMeal
//        mealEntity.strCategory = meal.strCategory
//        mealEntity.dateModified = Date().description
//        try context.save()
//    }
    
    func deleteEntity(with meal: Meal) async throws {
        guard let mealEntity = try await fetchSingleItemFromDatabase(idMeal: meal.idMeal) else {
            print("MealEntity with idMeal: \(meal.idMeal) not found.")
            return
        }
        context.delete(mealEntity)
        try context.save()
//        print("Note with uuid: \(note.uuid), deleted!")
    }
    
    func deleteAllRecords() async throws {
        let coreDataGenericManager: GenericPersistenceManager = GenericPersistenceManager(context: context)
        try await coreDataGenericManager.clearData(entityType: MealEntity.self)
    }
}
