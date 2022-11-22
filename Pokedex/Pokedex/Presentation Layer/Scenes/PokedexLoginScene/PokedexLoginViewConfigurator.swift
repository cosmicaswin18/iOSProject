//
//  PokedexLoginViewConfigurator.swift
//  Pokedex
//
//  Created by durgesh-10379 on 30/08/21.
//

import Foundation

class PokedexLoginViewConfigurator {
    
    static func configureModule(viewController: PokedexLoginViewController) {
        let view = PokedexLoginView()
        let router = PokedexLoginViewRouterImplementation()
        let interactor = PokedexLoginViewInteractorImplementation()
        let presenter = PokedexLoginViewPresenterImplementation()
        
        viewController.loginView = view
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
    }
}
