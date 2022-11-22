//
//  PokedexUserInfoInteractor.swift
//  Pokedex
//
//  Created by durgesh-10379 on 28/09/21.
//

import Foundation

protocol PokedexUserInfoInteractor: class {
    func viewDidLoadUser(with userInfo: AppUser)
}

class PokedexUserInfoInteractorImplementation: PokedexUserInfoInteractor {
    
    var presenter: PokedexUserInfoPresenter?
    
    func viewDidLoadUser(with userInfo: AppUser) {
        self.presenter?.interactor(didRetrieveUser: userInfo)
    }
}
