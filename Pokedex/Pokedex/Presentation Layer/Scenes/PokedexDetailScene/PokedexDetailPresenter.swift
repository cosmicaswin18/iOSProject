//
//  PokedexDetailPresenter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 26/08/21.
//

import Foundation

protocol PokedexDetailPresenter: class {
    func interactor(didRetrievePokemon pokemon: Pokemon?)
}

class PokedexDetailPresenterImplementation: PokedexDetailPresenter {
    
    var viewController: PokedexDetailPresenterOutput?
    
    func interactor(didRetrievePokemon pokemon: Pokemon?) {
        viewController?.presenter(didRetrievePokemon: pokemon!)
    }
    
}
