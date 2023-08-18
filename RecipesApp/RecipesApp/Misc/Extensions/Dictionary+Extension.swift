//
//  Dictionary+Extension.swift
//  RecipesApp
//
//  Created by Consultant on 8/18/23.
//

import Foundation

/**
 SwiftUI Usage:

 struct ContentView: View {
     @AppStorage("myDictionaryKey") private var dictionaryRawValue = "{}"

     var body: some View {
         Button("Save Dictionary") {
             let dictionary: [String: String] = ["key1": "value1", "key2": "value2"]
             dictionaryRawValue = dictionary.rawValue
         }

         Button("Retrieve Dictionary") {
             if let decodedDictionary = [String: String](rawValue: dictionaryRawValue) {
                 print(decodedDictionary)
             }
         }
     }
 }
 */

extension Dictionary: RawRepresentable where Key == String, Value == String {
    
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),  // convert from String to Data
            let result = try? JSONDecoder().decode([String:String].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),   // data is  Data type
              let result = String(data: data, encoding: .utf8) // coerce NSData to String
        else {
            return "{}"  // empty Dictionary resprenseted as String
        }
        return result
    }

}
