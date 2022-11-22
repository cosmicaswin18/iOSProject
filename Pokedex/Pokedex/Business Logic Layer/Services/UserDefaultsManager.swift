//
//  UserDefaultsManager.swift
//  Pokedex
//
//  Created by durgesh-10379 on 01/09/21.
//

import Foundation

struct Constants {
    
    struct Authentication {
        static let userIsLoggedIn = "UserIsLoggedIn"
    }
    
    private init() {
        
    }
}

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() {
        
    }
    
    var userIsLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.Authentication.userIsLoggedIn)
        }
        
        set {
            return UserDefaults.standard.setValue(newValue, forKey: Constants.Authentication.userIsLoggedIn)
        }
    }
    
}
