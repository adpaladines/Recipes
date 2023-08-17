//
//  NetworkProtocolDelegate.swift
//  MVVMAPICallSwiftUI
//
//  Created by Andres D. Paladines on 7/18/23.
//

import Foundation
import Combine

protocol NetworkAbleProtocol {
    
    func getDataFromApi<T:Decodable>(urlRequest: URLRequest, type: T.Type) -> AnyPublisher<T,Error> where T : Decodable
    func getDataFromMultipleApi<T>(urlRequests: [URLRequest], type: T.Type) -> [AnyPublisher<T, Error>] where T: Decodable
    
}
