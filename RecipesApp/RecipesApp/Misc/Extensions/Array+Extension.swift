//
//  Array+Extension.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/17/23.
//

import Foundation

extension Array {
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
}

/**
 SwiftUI Usage:

 struct ContentView: View {
     @AppStorage("myArrayKey") private var arrayRawValue = "[]"

     var body: some View {
         Button("Save Array") {
             let array: [String] = ["one", "two", "three"]
             arrayRawValue = array.rawValue
         }

         Button("Retrieve Array") {
             if let decodedArray = [String](rawValue: arrayRawValue) {
                 print(decodedArray)
             }
         }
     }
 }
 */

extension Array: RawRepresentable where Element == String {

    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([String].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"  // empty Array represented as String
        }
        return result
    }

}
