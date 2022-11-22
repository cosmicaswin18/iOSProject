//
//  PokedexListConfigurator.swift
//  Pokedex
//
//  Created by durgesh-10379 on 25/08/21.
//

import UIKit

class PokedexListConfigurator {
    
    static func configureModule(viewController: PokedexListViewController) {
        let pokedexCell = PokedexListCell()
        let router = PokedexListRouterImplementation()
        let interactor = PokedexListInteractorImplementation()
        let presenter = PokedexListPresenterImplementation()
        
        viewController.pokedexCell = pokedexCell
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
    }
}
