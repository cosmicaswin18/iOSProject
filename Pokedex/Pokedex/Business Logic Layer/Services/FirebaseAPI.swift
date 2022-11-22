//
//  FireBaseAPI.swift
//  Pokedex
//
//  Created by durgesh-10379 on 01/09/21.
//

import Foundation
import Firebase

struct FirebaseAPI {
    
    static let shared = FirebaseAPI()
    
    private init() {
        
    }
    
    private let ref = Database.database().reference(fromURL: "https://pokedexlogin-default-rtdb.firebaseio.com/")
    
    var userID: String? {
        get {
            Auth.auth().currentUser?.uid
        }
    }
    
    func signUp(name: String, email: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        let userData: [String: Any] = [
            "name": name
        ]
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                completionHandler(err)
            } else {
                guard let uid = result?.user.uid else { return }
                self.ref.child("users/\(uid)").setValue(userData)
                UserDefaultsManager.shared.userIsLoggedIn = false
                print("Successfully created a User: ", uid)
                completionHandler(nil)
            }
        }
    }
    
    func logOut(completionHandler: (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaultsManager.shared.userIsLoggedIn = false
            completionHandler(nil)
        } catch let err {
            print(err.localizedDescription)
            completionHandler(err)
        }
    }
    
    func logIn(email: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error {
                completionHandler(err)
                print(err.localizedDescription)
            } else {
                guard let uid = user?.user.uid else { return }
                print("User: \(uid) is logged in successfully")
                UserDefaultsManager.shared.userIsLoggedIn = true
                completionHandler(nil)
            }
        }
    }
    
    func fetch(completionHandler: @escaping (AppUser?) -> Void) {
        guard let userID = userID else { return }
        ref.child("users").child(userID).observeSingleEvent(of: .value) { (snapshot) in
            let appUser = AppUser(snapshot: snapshot)
            completionHandler(appUser)
            print("Successfully fetched user info")
        }
    }
}
