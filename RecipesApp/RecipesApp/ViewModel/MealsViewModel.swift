//
//  MealsViewModel.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/16/23.
//

import Foundation
import SwiftUI
import Combine

enum PreferredCaregory: Int {
    case one
    case two
    case three
}


class MealsViewModel: ObservableObject {

    @AppStorage(UserDefaultsKeys.preferredCategories.rawValue) private var preferredCategories = "[]"
    
    @Published var customError: NetworkError?
    @Published var isLoading: Bool = false

    @Published var prefOneMealPreviewsList: [MealPreview] = []
    @Published var prefOneMealPreviewsListFiltered: [MealPreview] = []

    @Published var prefTwoMealPreviewsList: [MealPreview] = []
    @Published var prefTwoMealPreviewsListFiltered: [MealPreview] = []
    
    @Published var prefThreeMealPreviewsList: [MealPreview] = []
    @Published var prefThreeMealPreviewsListFiltered: [MealPreview] = []
    
    @Published var selectedMeal: Meal?

    private let networkManager: NetworkAbleProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkManager: NetworkAbleProtocol) {
        self.networkManager = networkManager
//        let array: [String] = ["Beef"]
//        preferredCategories = array.rawValue
//        if let decodedArray = [String](rawValue: preferredCategories) {
//            print(decodedArray)
//        }
    }
    
    func fetchMealById(_ id: String) {
        let urlString = ApiManager.api(.lookupForId(str: id))
        guard let request = UrlGen.shared.from(urlString) else {
            return
        }
        self.networkManager.getDataFromApi(urlRequest: request, type: MealsSearchLookupResp.self)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("fetchMealById \(id) finished")
                    self.isLoading = false
                case .failure(let error):
                    self.customError = NetworkError.getNetwork(error: error)
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] value in
//                self?.mealsFilterResponseList.append(value)
//                self?.prefOneMealPreviewsList.append(contentsOf: value.meals)
//                self?.prefOneMealPreviewsListFiltered.append(contentsOf: value.meals)
                if let meal = value.meals.first {
                    print(meal)
                    self?.selectedMeal = meal
                }
            })
            .store(in: &cancellables)
    }

    //OK merge multiple requests in a single response.
    //https://www.themealdb.com/api/json/v1/1/filter.php?c=Beef & https://www.themealdb.com/api/json/v1/1/filter.php?c=Garlic
    func getMealsBy(_ categories: [String]) {
        let listOfUrlStrings: [String] = categories.compactMap{  ApiManager.api(.filterCategory(str: $0)) }
        let urls = UrlGen.shared.from(urlStrings: listOfUrlStrings)
        let urlRequests = urls.map{ URLRequest(url: $0) }

        let publishers =  self.networkManager.getDataFromMultipleApi(urlRequests: urlRequests, type: MealsFilterResponse.self)
        Publishers
            .MergeMany(publishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("")
                    break
                case .failure(let error):
                    // Handle the error, if needed
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] values in
                print(values)
                values.forEach { mealPreviewsResponse in
                    self?.prefOneMealPreviewsList.append(contentsOf: mealPreviewsResponse.meals)
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchPreviewMealsFromAPI(_ category: String) {
            let urlString = ApiManager.api(.filterCategory(str: category))

            guard let request = UrlGen.shared.from(urlString) else {
                return
            }
            self.networkManager.getDataFromApi(urlRequest: request, type: MealsFilterResponse.self)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("fetchPreviewMealsFromAPIs finished")
                        self.isLoading = false
                    case .failure(let error):
                        self.customError = NetworkError.getNetwork(error: error)
                        print(error.localizedDescription)
                        self.isLoading = false
                    }
                }, receiveValue: { [weak self] mealPreviewsResponse in
                    guard let self_ = self else {
                        print("SELF FAILED!")
                        return
                    }
                    var newCat = mealPreviewsResponse
                    newCat.strCategory = category
                    self_.prefOneMealPreviewsList = newCat.meals
                    self_.prefOneMealPreviewsListFiltered = newCat.meals
                })
                .store(in: &cancellables)
        
    }
    
    func fetchPreviewByMainIngredient(_ ingredient: String) {
        let urlString = ApiManager.api(.filterMainIngredient(str: ingredient))
        guard let request = UrlGen.shared.from(urlString) else {
            return
        }
        self.networkManager.getDataFromApi(urlRequest: request, type: MealsFilterResponse.self)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("fetchPreviewByMainIngredient finished")
                    self.isLoading = false
                case .failure(let error):
                    self.customError = NetworkError.getNetwork(error: error)
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] value in
//                self?.mealsFilterResponseList.append(value)
                self?.prefOneMealPreviewsList.append(contentsOf: value.meals)
                self?.prefOneMealPreviewsListFiltered.append(contentsOf: value.meals)
            })
            .store(in: &cancellables)
    }
    
}
