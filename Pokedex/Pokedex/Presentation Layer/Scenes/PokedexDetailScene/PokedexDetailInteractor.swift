//
//  PokedexDetailInteractor.swift
//  Pokedex
//
//  Created by durgesh-10379 on 26/08/21.
//

import Foundation

protocol PokedexDetailInteracor: class {
    func viewDidLoadPokemon(with pokemon: Pokemon)
}

class PokedexDetailInteractorImplementation: PokedexDetailInteracor {
    
    var presenter: PokedexDetailPresenter?
    
    func viewDidLoadPokemon(with pokemon: Pokemon) {
        self.presenter?.interactor(didRetrievePokemon: pokemon)
    }
}
