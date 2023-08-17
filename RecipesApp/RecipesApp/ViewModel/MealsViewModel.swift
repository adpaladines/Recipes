//
//  MealsViewModel.swift
//  RecipesApp
//
//  Created by Consultant on 8/16/23.
//

import Foundation
import Combine

class MealsPreferencesViewModel: ObservableObject {

}
class MealsStoredViewModel:ObservableObject {

}
class MealsPersistenceManager {

}

class MealsViewModel: ObservableObject {

    @Published var customError: NetworkError?
    @Published var isLoading: Bool = false

    @Published var categoriesList: [Category] = []
    @Published var categoriesListFiltered: [Category] = []

    @Published var mealsFilterResponseList: [MealsFilterResponse] = []
    @Published var mealPreviewsList: [MealPreview] = []
    @Published var mealPreviewsListFiltered: [MealPreview] = []



//    @AppStorage("tapCount") private var tapCount = 0

    private let networkManager: NetworkAbleProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkManager: NetworkAbleProtocol) {
        self.networkManager = networkManager
    }
//OK
    func getCategories() {
        guard let request = UrlGen.shared.from(ApiManager.api(.categories)) else {
            isLoading = false
            customError = .invalidUrlError
            return
        }
        
        self.networkManager.getDataFromApi(urlRequest: request, type: CategoriesResponse.self)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Task finished")
                    self.isLoading = false
                case .failure(let error):
                    self.customError = NetworkError.getNetwork(error: error)
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { result in
                self.categoriesList += result.categories.sorted(by: {$0.idCategory < $1.idCategory})
                self.categoriesListFiltered = self.categoriesList
            })
            .store(in: &cancellables)
    }

    //OK merge multiple requests in a single response.
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
                    // All requests completed successfully
                    break
                case .failure(let error):
                    // Handle the error, if needed
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] values in
                print(values)
                values.forEach { mealPreviewsResponse in
                    let newCat = mealPreviewsResponse
                    self?.mealsFilterResponseList.append(mealPreviewsResponse)
                    self?.mealPreviewsList.append(contentsOf: mealPreviewsResponse.meals)
                }
            })
            .store(in: &cancellables)
    }

    func fetchDataFromMultipleAPIs(_ categories: [String]) {
        categories.forEach { category in
            let urlString = ApiManager.api(.filterCategory(str: category))

            guard let request = UrlGen.shared.from(urlString) else {
                return
            }
            self.networkManager.getDataFromApi(urlRequest: request, type: MealsFilterResponse.self)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Task finished")
                        self.isLoading = false
                    case .failure(let error):
                        self.customError = NetworkError.getNetwork(error: error)
                        print(error.localizedDescription)
                        self.isLoading = false
                    }
                }, receiveValue: { [weak self] mealPreviewsResponse in
                    var newCat = mealPreviewsResponse
                    newCat.strCategory = category
                    self?.mealsFilterResponseList.append(newCat)

                    self?.mealPreviewsList.append(contentsOf: mealPreviewsResponse.meals)
                })
                .store(in: &cancellables)
        }
    }

    func getListOf(_ topics: [Topic]) {
        let request = URLRequest(url: URL(string: "")!)
        self.networkManager.getDataFromApi(urlRequest: request, type: CategoriesResponse.self)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Task finished")
                    self.isLoading = false
                case .failure(let error):
                    self.customError = NetworkError.getNetwork(error: error)
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { result in
                self.categoriesList += result.categories.sorted(by: {$0.idCategory < $1.idCategory})
                self.categoriesListFiltered = self.categoriesList
            })
            .store(in: &cancellables)
    }

}
