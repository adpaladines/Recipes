//
//  FavoriteMealsViewModel.swift
//  RecipesApp
//
//  Created by andres paladines on 8/21/23.
//

import Foundation

class FavoriteMealsViewModel: ObservableObject {
    
    @Published var customError: NetworkError?
    @Published var isLoading: Bool = false

    @Published var mealsList: [Meal] = []
    @Published var mealsListFiltered: [Meal] = []

    private let context = PersistenceController.shared.container.newBackgroundContext()
    
    func fetchMealsListFromDB() async {
        do {
            customError = nil
            let coreDataManager = MealsPersistenceManager(context: context)
            let myDBList = try await coreDataManager.fetchDataFromDatabase()

            let itemsList = myDBList.compactMap({Meal(from: $0)})
            self.mealsList = itemsList
            self.mealsListFiltered = itemsList
            if itemsList.isEmpty {
                customError = .dataNotFoundError
            }
        }catch let error {
            print(error.localizedDescription)
            customError = .parsingError
        }
    }
    
    func fetchMealById(_ mealId: String) async -> Meal? {
        do {
            let coreDataManager = MealsPersistenceManager(context: context)
            let mealEntity = try await coreDataManager.fetchSingleItemFromDatabase(idMeal: mealId)
            guard let meal = mealEntity else {
                customError = .dataNotFoundError
                return nil
            }
            let myMeal = Meal(from: meal)
            return myMeal
        }catch let error {
            print(error.localizedDescription)
            customError = .parsingError
            return nil
        }
    }
    
    func add(new meal: Meal) async {
        do {
            try await saveNotesListInDB(item: meal)
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveNotesListInDB(item: Meal) async throws {
        let coreDataManager = MealsPersistenceManager(context: context)
        try await coreDataManager.saveDataIntoDatabase(item: item)
    }
    
    func delete(meal: Meal) async {
        do {
            let mealsDataGenericManager = MealsPersistenceManager(context: context)
            try await mealsDataGenericManager.deleteEntity(with: meal)
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func eraseDatabase() async {
        do {
            let mealsDataGenericManager = MealsPersistenceManager(context: context)
            try await mealsDataGenericManager.deleteAllRecords()
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
}
