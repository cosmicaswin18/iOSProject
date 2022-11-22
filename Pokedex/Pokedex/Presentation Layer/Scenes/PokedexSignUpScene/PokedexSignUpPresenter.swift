//
//  PokedexSignUpViewPresenter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 01/09/21.
//

import Foundation

protocol PokedexSignUpPresenter {
    func interactor(showSubmitSuccess message: String)
    func interactor(showSubmitFailure message: String)
}

class PokedexSignUpPresenterImplementation: PokedexSignUpPresenter {
    
    weak var viewController: PokedexSignUpPresenterOutput?
    
    func interactor(showSubmitSuccess message: String) {
        viewController?.presenter(showSubmitSuccess: message)
    }
    
    func interactor(showSubmitFailure message: String) {
        viewController?.presenter(showSubmitFailure: message)
    }
    
}
