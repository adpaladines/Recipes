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

//    @AppStorage("tapCount") private var tapCount = 0

    private let networkManager: NetworkAbleProtocol
    private var cancelable = Set<AnyCancellable>()

    init(networkManager: NetworkAbleProtocol) {
        self.networkManager = networkManager
    }

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
            .store(in: &cancelable)
    }

    func getListOf(_ topic: Topic) {
        guard let request = UrlGen.shared.from(ApiManager.api(.listAllTopics(topic: topic))) else {
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
            .store(in: &cancelable)
    }

}
