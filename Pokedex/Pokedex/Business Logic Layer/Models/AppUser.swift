//
//  AppUser.swift
//  Pokedex
//
//  Created by durgesh-10379 on 01/09/21.
//

import Foundation
import Firebase

struct AppUser {
    var name: String?
    var uid: String?
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else { return }
        guard let name = value["name"] as? String else { return }
        self.name = name
    }
}
