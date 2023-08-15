//
//  NetworkResponseProtocol.swift
//  MVVMAPICallSwiftUI
//
//  Created by Andres D. Paladines on 7/18/23.
//

import Foundation

protocol NetworkResponseProtocol {
    func didReceiveError(error: Error)
    func didReceivedDataFromAPI<T: Decodable>(data: T)
}
