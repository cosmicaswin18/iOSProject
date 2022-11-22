//
//  PokedexBattleConfigurator.swift
//  Pokedex
//
//  Created by durgesh-10379 on 08/09/21.
//

import UIKit

class PokedexBattleConfigurator {
    
    static func configureModule(viewController: PokedexBattleViewController) {
        let view = PokedexBattleView()
        let router = PokedexBattleRouterImplementation()
        let interactor = PokedexBattleInteractorImplementation()
        let presenter = PokedexBattlePresenterImplementation()
        
        viewController.pokemonBattleView = view
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
    }
}
