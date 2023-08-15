//
//  FakeNetworkManager.swift
//  TheSoundsStore
//
//  Created by Andres D. Paladines on 7/19/23.
//

import Foundation
import Combine

class FakeNetworkManager: NetworkAbleProtocol {
    
    var timeoutActive: Bool = false
    
    func getDataFromApi<T>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        guard !timeoutActive else {
            return Fail(error: NetworkError.timeOutError)
                .eraseToAnyPublisher()
        }
        let bundle = Bundle(for: FakeNetworkManager.self)
        let urlString = urlRequest.url?.absoluteString
        guard let url = bundle.url(forResource: urlString, withExtension: "json") else {
            return Fail(error: NetworkError.invalidUrlError)
                .eraseToAnyPublisher()
        }
        do {
            let data = try Data(contentsOf: url)
            let planetsList = try JSONDecoder().decode(type.self, from: data)
            return Just(planetsList)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch let error {
            print(error.localizedDescription)
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

}
