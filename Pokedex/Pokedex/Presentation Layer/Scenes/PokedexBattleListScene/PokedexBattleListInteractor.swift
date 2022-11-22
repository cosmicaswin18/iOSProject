//
//  PokedexBattleListInteractor.swift
//  Pokedex
//
//  Created by durgesh-10379 on 13/09/21.
//

import Foundation

protocol PokedexBattleListInteractor {
    func selectPokemon(with pokemon: Pokemon?)
}

class PokedexBattleListInteractorImplementation: PokedexBattleListInteractor {
    
    var presenter: PokedexBattleListPresenter?
    
    func selectPokemon(with pokemon: Pokemon?) {
        guard let pokemon = pokemon else { return }
        
        presenter?.interactor(didSelectPokemon: pokemon)
    }
}
