//
//  PokedexDetailConfigurator.swift
//  Pokedex
//
//  Created by durgesh-10379 on 26/08/21.
//

import Foundation

class PokedexDetailConfigurator {
    
    static func configureModule(pokemon: Pokemon, viewController: PokedexDetailViewController) {
        let view = PokedexDetailView()
        let router = PokedexDetailRouterImplementation()
        let interactor = PokedexDetailInteractorImplementation()
        let presenter = PokedexDetailPresenterImplementation()
        
        
        viewController.pokemonDetailView = view
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
    }
}
