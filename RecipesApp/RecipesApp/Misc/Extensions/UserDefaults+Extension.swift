//
//  UserDefaults+Extension.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/16/23.
//

import Foundation

extension UserDefaults {

    func set<T>(_ value: T, with key: UserDefaultsKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func getInt(key: UserDefaultsKeys) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }

    func getString(key: UserDefaultsKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }

//    let dictionary: [String: String] = ["key1": "value1", "key2": "value2"]
//    UserDefaults.standard.set(dictionary.rawValue, forKey: "myDictionaryKey")
    func getDictionary(key: UserDefaultsKeys) -> Dictionary<String, String>? {
        if let rawValue = UserDefaults.standard.string(forKey: key.rawValue),
           let decodedDictionary = [String: String](rawValue: rawValue) {
            return decodedDictionary
        }
        return nil
    }

//    let stringArray: [String] = ["one", "two", "three"]
//    UserDefaults.standard.set(stringArray.rawValue, forKey: "myStringArrayKey")
    func getArrayOfStringsFor(key: UserDefaultsKeys) -> Array<String>? {
        if let storedRawValue = UserDefaults.standard.string(forKey: key.rawValue),
           let decodedArray = [String](rawValue: storedRawValue) {
            return decodedArray
        }
        return nil
    }
}
