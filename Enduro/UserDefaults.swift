//
//  UserDefaults.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/22/23.
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        static let userPreferences = "userPreferences"
    }
    
    var userPreferences: UserPreferences? {
        get {
            if let data = UserDefaults.standard.data(forKey: Keys.userPreferences) {
                return try? JSONDecoder().decode(UserPreferences.self, from: data)
            }
            return nil
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: Keys.userPreferences)
        }
    }
}
