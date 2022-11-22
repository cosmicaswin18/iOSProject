//
//  PokedexSignUpViewInteractor.swift
//  Pokedex
//
//  Created by durgesh-10379 on 01/09/21.
//

import Foundation

protocol PokedexSignUpInteractor {
    func submitTapped(name: String, email: String, password: String)
    //    func signUpTapped(message: String)
}

class PokedexSignUpInteractorImplementation: PokedexSignUpInteractor {
    
    var presenter: PokedexSignUpPresenter?
    
    func submitTapped(name: String, email: String, password: String) {
        FirebaseAPI.shared.signUp(name: name, email: email, password: password) { [weak self] (err) in
            if err != nil {
                self?.presenter?.interactor(showSubmitFailure: err!.localizedDescription)
            } else {
                self?.presenter?.interactor(showSubmitSuccess: "Submitted Successfuly")
            }
        }
    }
    
}
