//
//  PokedexBattlePresenter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 08/09/21.
//

import Foundation

protocol PokedexBattlePresenter: class {
    func interactor(selectFromListSuccess message: String)
    func interactor(backToPokedexList message: String)
    func interactor(winnnerIs pokemon: Pokemon)
}

class PokedexBattlePresenterImplementation: PokedexBattlePresenter {
    
    weak var viewController: PokedexBattlePresenterOutput?
    
    func interactor(selectFromListSuccess message: String) {
        viewController?.presenter(selectFromList: message)
    }
    
    func interactor(backToPokedexList message: String) {
        viewController?.presenter(backToPokedex: message)
    }
    
    func interactor(winnnerIs pokemon: Pokemon) {
        viewController?.presenter(winnerIs: pokemon)
    }
    
}

