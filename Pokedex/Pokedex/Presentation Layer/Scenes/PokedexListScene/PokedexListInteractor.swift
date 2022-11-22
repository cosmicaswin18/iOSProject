//
//  PokedexListInteractor.swift
//  Pokedex
//
//  Created by durgesh-10379 on 25/08/21.
//

import UIKit

protocol PokedexListInteractor {
    func selectPokemon(with pokemon: Pokemon?)
    func filterPokemon(with type: String, from pokemon: [Pokemon])
    func battleScreen()
    func fetchUserInfo()
    func logout()
}

class PokedexListInteractorImplementation: PokedexListInteractor {
   
    var presenter: PokedexListPresenter?
   
    func selectPokemon(with pokemon: Pokemon?) {
        guard let pokemon = pokemon else { return }
        
        presenter?.interactor(didSelectPokemon: pokemon)
    }
    
    func filterPokemon(with type: String, from pokemon: [Pokemon]) {
        var filteredPokemon = [Pokemon]()
        filteredPokemon = pokemon.filter({$0.type?.range(of: type, options: .caseInsensitive) != nil })
        presenter?.interactor(filteredPokemons: filteredPokemon, with: type)
    }
    
    func battleScreen() {
        presenter?.interactor(battleScreen: "Battle Screen Entered Successfully")
    }
    
    
    func fetchUserInfo() {
        FirebaseAPI.shared.fetch { [weak self] (user) in
            if user != nil {
                self?.presenter?.interactor(userInfo: user)
            }
        }
    }
    
    func logout() {
        FirebaseAPI.shared.logOut { [weak self] (err) in
            if err != nil {
                self?.presenter?.interactor(logoutFailure: err!.localizedDescription)
            } else {
                BattleStats.battleWin = 0
                BattleStats.battleLose = 0
                BattleStats.battleDraw = 0
                BattleStats.totalBattles = 0
                self?.presenter?.interactor(logoutSucess: "Logout Successful")
            }
        }
    }
    
}
