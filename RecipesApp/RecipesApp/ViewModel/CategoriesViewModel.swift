//
//  CategoriesViewModel.swift
//  RecipesApp
//
//  Created by andres paladines on 8/20/23.
//

import Foundation
import Combine

class CategoriesViewModel: ObservableObject {

    @Published var customError: NetworkError?
    @Published var isLoading: Bool = false
    
    @Published var categoriesList: [Category] = []
    @Published var categoriesListFiltered: [Category] = []
    
    private let networkManager: NetworkAbleProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkManager: NetworkAbleProtocol) {
        self.networkManager = networkManager
    }
    
    //https://www.themealdb.com/api/json/v1/1/categories.php
    func fetchAllCategories() {
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
                    print("fetchAllCategories finished")
                    self.isLoading = false
                case .failure(let error):
                    self.customError = NetworkError.getNetwork(error: error)
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }, receiveValue: { result in
                self.categoriesList = result.categories.sorted(by: {$0.idCategory < $1.idCategory})
                self.categoriesListFiltered = self.categoriesList
            })
            .store(in: &cancellables)
    }
    
    //List all Categories, Area, Ingredients
    func getListOf(_ topic: Topic) {
        let urlString = ApiManager.api(.listBy(topic: topic))
        guard let request = UrlGen.shared.from(urlString) else {
            return
        }
        self.networkManager.getDataFromApi(urlRequest: request, type: CategoriesResponse.self)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("getListOf finished")
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

