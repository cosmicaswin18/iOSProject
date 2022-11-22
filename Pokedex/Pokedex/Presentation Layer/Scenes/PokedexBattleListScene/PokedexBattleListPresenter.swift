//
//  PokedexBattleListPresenter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 13/09/21.
//

import Foundation

protocol PokedexBattleListPresenter {
    func interactor(didSelectPokemon pokemon: Pokemon?)
}

class PokedexBattleListPresenterImplementation: PokedexBattleListPresenter {
    
    var viewController: PokedexBattleListPresenterOutput?
    
    func interactor(didSelectPokemon pokemon: Pokemon?) {
        if let pokemon = pokemon {
            viewController?.presenter(didSelectPokemon: pokemon)
        }
    }
}
