//
//  PokedexBattleListRouter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 13/09/21.
//

import UIKit

protocol PokedexBattleListRouter {
    var navigationController: UINavigationController? { get }
    
    func routeToBattle(pokemon: Pokemon)
}

class PokedexBattleListRouterImplementation: PokedexBattleListRouter {
    
    var navigationController: UINavigationController?
    
    func routeToBattle(pokemon: Pokemon) {
        let controller = PokedexBattleViewController()
        controller.pokemon = pokemon
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .overFullScreen
        PokedexBattleConfigurator.configureModule(viewController: controller)
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
}
