//
//  PokedexLoginViewInteractor.swift
//  Pokedex
//
//  Created by durgesh-10379 on 30/08/21.
//

import Foundation

protocol PokedexLoginViewInteractor {
    func loginTapped(email: String, password: String)
    func signUpTapped(message: String)
}

class PokedexLoginViewInteractorImplementation: PokedexLoginViewInteractor {
    var presenter: PokedexLoginViewPresenter?
    
    func loginTapped(email: String, password: String) {
        FirebaseAPI.shared.logIn(email: email, password: password) { [weak self] (err) in
            if err != nil {
                self?.presenter?.interactor(showLoginFailure: err!.localizedDescription)
            } else {
                self?.presenter?.interactor(showLoginSuccess: "Login Success")
            }
        }
    }
    
    func signUpTapped(message: String) {
        presenter?.interactot(showSignUpSuccess: message)
    }
}
