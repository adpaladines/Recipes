//
//  UserDefaults+Extension.swift
//  RecipesApp
//
//  Created by Consultant on 8/16/23.
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

    func getDictionary(key: UserDefaultsKeys) -> Dictionary<String, Any>? {
        return UserDefaults.standard.dictionary(forKey: key.rawValue)
    }
 
}
