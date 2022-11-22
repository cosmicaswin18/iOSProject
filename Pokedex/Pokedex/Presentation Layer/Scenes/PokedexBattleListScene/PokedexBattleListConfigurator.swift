//
//  PokedexBattleListConfigurator.swift
//  Pokedex
//
//  Created by durgesh-10379 on 13/09/21.
//

import Foundation

class PokedexBattleListConfigurator {
    
    static func configureModule(viewController: PokedexBattleListController) {
        let pokedexBattleListCell = PokedexBattleListCell()
        let router = PokedexBattleListRouterImplementation()
        let interactor = PokedexBattleListInteractorImplementation()
        let presenter = PokedexBattleListPresenterImplementation()
        
        viewController.pokedexBattleListCell = pokedexBattleListCell
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
    }
}
