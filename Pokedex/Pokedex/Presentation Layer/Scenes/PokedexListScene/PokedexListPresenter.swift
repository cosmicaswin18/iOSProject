//
//  PokedexListPresenter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 25/08/21.
//

import Foundation

protocol PokedexListPresenter {
    func interactor(didSelectPokemon pokemon: Pokemon?)
    func interactor(filteredPokemons pokemon: [Pokemon], with type: String)
    func interactor(battleScreen message: String)
    func interactor(userInfo user: AppUser?)
    func interactor(logoutSucess message: String)
    func interactor(logoutFailure message: String)
}

class PokedexListPresenterImplementation: PokedexListPresenter {
    
    
    weak var viewController: PokedexListPresenterOutput?
    
    func interactor(didSelectPokemon pokemon: Pokemon?) {
        if let pokemon = pokemon {
            viewController?.presenter(didObtainPokemon: pokemon)
        }
    }
    
    func interactor(filteredPokemons pokemon: [Pokemon], with type: String) {
        viewController?.presenter(filteredPokemons: pokemon, with: type)
    }
    
    func interactor(userInfo user: AppUser?) {
        viewController?.presenter(userInfo: user)
    }
    
    func interactor(battleScreen message: String) {
        viewController?.presenter(battleScreen: message)
    }
    
    func interactor(logoutSucess message: String) {
        viewController?.presenter(logoutSuccess: message)
    }
    
    func interactor(logoutFailure message: String) {
        viewController?.presenter(logoutFailure: message)
    }
    
}
