//
//  PokedexUserInfoPresenter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 28/09/21.
//

import Foundation

protocol PokedexUserInfoPresenter: class {
    func interactor(didRetrieveUser userInfo: AppUser)
}

class PokedexUserInfoPresenterImplementation: PokedexUserInfoPresenter {
    
    var viewController: PokedexUserInfoPresenterOutput?
    
    func interactor(didRetrieveUser userInfo: AppUser) {
        viewController?.presenter(didRetrieveUser: userInfo)
    }
    
}
