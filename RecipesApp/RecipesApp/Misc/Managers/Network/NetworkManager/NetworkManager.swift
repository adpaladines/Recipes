//
//  NetworkManager.swift
//  MVVMAPICallSwiftUI
//
//  Created by Andres D. Paladines on 7/18/23.
//

import Foundation
import Combine

class NetworkManager: NetworkAbleProtocol {

    func getDataFromApi<T>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T: Decodable {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    if (response as? HTTPURLResponse)?.statusCode == 404 {
                        throw NetworkError.dataNotFoundError
                    }else {
                        throw NetworkError.responseError
                    }
                }
                return data
            })
//            .delay(for: .seconds(3), scheduler: DispatchQueue.main)
//            .throttle(for: .seconds(10), scheduler: DispatchQueue.main, latest: true)
            .decode(type: type.self, decoder: JSONDecoder()) // - Parsing
            .eraseToAnyPublisher()
    }

    func getDataFromMultipleApi<T>(urlRequests: [URLRequest], type: T.Type) -> [AnyPublisher<T, Error>] where T: Decodable {
        var publishers: [AnyPublisher<T, Error>] = []
        publishers = urlRequests.map({ urlRequest in
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap({ (data: Data, response: URLResponse) in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        if (response as? HTTPURLResponse)?.statusCode == 404 {
                            throw NetworkError.dataNotFoundError
                        }else {
                            throw NetworkError.responseError
                        }
                    }
                    return data
                })
                .decode(type: type.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        })
        return publishers
    }
}

