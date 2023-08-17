//
//  UrlGen.swift
//  RecipesApp
//
//  Created by Consultant on 8/16/23.
//

import Foundation

class UrlGen {
    static let shared: UrlGen = .init()
    private init() {}

    func from(_ string: String) -> URLRequest? {
        guard let url = URL(string: string) else {
            return nil
        }

        let request = URLRequest(url: url)
        return request
    }

    func from(urlStrings: [String]) -> [URL] {
        var result: [URL] = []
        urlStrings.forEach { urlString in
            if let url = URL(string: urlString) {
                result.append(url)
            }
        }
        return result
    }

}
