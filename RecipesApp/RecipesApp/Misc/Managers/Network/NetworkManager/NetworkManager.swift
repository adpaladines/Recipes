//
//  NetworkManager.swift
//  MVVMAPICallSwiftUI
//
//  Created by Andres D. Paladines on 7/18/23.
//

import Foundation
import Combine

class NetworkManager: NetworkAbleProtocol {
    
    func getFakeData(urlRequest: URLRequest) -> AnyPublisher<Data, Error>? {
        guard let myData = "New Data from login".data(using: .utf8) else {
            return Fail(error: NSError(domain: "Error", code: 9)).eraseToAnyPublisher()
        }
        return Just(myData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getDataFromApi<T>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T: Decodable {
        
        let customConfiguration = URLSessionConfiguration.default
        customConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData

        customConfiguration.timeoutIntervalForRequest = 20
        customConfiguration.timeoutIntervalForResource = 30
        customConfiguration.httpAdditionalHeaders = [
            "Authorization": "Bearer YourAccessToken",
            "User-Agent": "MyApp/1.0"
        ]

        customConfiguration.networkServiceType = .responsiveData

        // Allow cellular access for this session
        customConfiguration.allowsCellularAccess = true

        // Create a URLSession with the custom configuration
        let customSession = URLSession(configuration: customConfiguration)

        // Create and perform a data task using the custom session
        if let url = URL(string: "https://example.com/api/data") {
            let task = customSession.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    // Process the response data here
                    print("Received data: \(data)")
                }
            }
            task.resume()
        }
        
        

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
//            .map{ $0.data: Data, response: URLResponse}
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

