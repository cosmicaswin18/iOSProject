//
//  PokedexBattleInteractor.swift
//  Pokedex
//
//  Created by durgesh-10379 on 08/09/21.
//

import UIKit

protocol PokedexBattleInteractor {
    func selectPokemonFromList()
    func backToPokedex()
    func battle(between pokemon1: Pokemon, and pokemon2: Pokemon)
}

class PokedexBattleInteractorImplementation: PokedexBattleInteractor {
    
    var presenter: PokedexBattlePresenter?
    
    func selectPokemonFromList() {
        self.presenter?.interactor(selectFromListSuccess: "Selection List Entered Successfully")
    }
    
    func backToPokedex() {
        self.presenter?.interactor(backToPokedexList: "Back To Pokedex Successful")
    }
    
    func battle(between pokemon1: Pokemon, and pokemon2: Pokemon) {
        
        var pokeAttack1 = pokemon1.attack
        var pokeAttack2 = pokemon2.attack
        
        let calcAttack = PokemonBattleLogic.shared.attackCalcByType(attack1: &(pokeAttack1)!, type1: (pokemon1.type?.lowercased())!, attack2: &(pokeAttack2)!, type2: (pokemon2.type?.lowercased())!)
        
        let attack1 = calcAttack.attack1
        let defense1 = pokemon1.defense
        let attack2 = calcAttack.attack2
        let defense2 = pokemon2.defense
        var poke: Pokemon?
        
        let damageByPokemon1 = attack1 - defense2!
        let damageByPokemon2 = attack2 - defense1!
        
        if damageByPokemon1 > damageByPokemon2 {
            print("\(String(describing: pokemon1.name)) has won")
            poke = pokemon1
            BattleStats.isDraw = false
            BattleStats.battleWin! += 1
        } else if damageByPokemon2 > damageByPokemon1 {
            print("\(String(describing: pokemon2.name)) has won")
            poke = pokemon2
            BattleStats.isDraw = false
            BattleStats.battleLose! += 1
        } else {
            print("The battle is a draw")
            poke = pokemon1
            BattleStats.isDraw = true
            BattleStats.battleDraw! += 1
        }
        
        BattleStats.totalBattles! += 1
        
        presenter?.interactor(winnnerIs: poke!)
    }
    
}

