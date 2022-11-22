//
//  PokedexLoginViewPresenter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 30/08/21.
//

import Foundation

protocol PokedexLoginViewPresenter {
    func interactor(showLoginSuccess message: String)
    func interactor(showLoginFailure message: String)
    func interactot(showSignUpSuccess message: String)
}

class PokedexLoginViewPresenterImplementation: PokedexLoginViewPresenter {
    weak var viewController: PokedexLoginViewPresenterOutput?
    
    func interactor(showLoginSuccess message: String) {
        viewController?.presenter(showLoginSuccess: message)
    }
    
    func interactor(showLoginFailure message: String) {
        viewController?.presenter(showLoginFailure: message)
    }
    
    func interactot(showSignUpSuccess message: String) {
        viewController?.presenter(showSignUpSuccess: message)
    }
    
    
}
