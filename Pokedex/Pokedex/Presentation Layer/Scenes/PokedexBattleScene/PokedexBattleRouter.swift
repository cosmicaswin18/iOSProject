//
//  PokedexBattleRouter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 08/09/21.
//

import UIKit

protocol PokedexBattleRouter {
    var navigationController: UINavigationController? { get }
    
    func routeToSelectionList()
    func routeToPokedexList()
}

class PokedexBattleRouterImplementation: PokedexBattleRouter {
    
    var navigationController: UINavigationController?
    
    func routeToSelectionList() {
        let viewController = PokedexBattleListController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .overFullScreen
        PokedexBattleListConfigurator.configureModule(viewController: viewController)
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func routeToPokedexList() {
        let layout = UICollectionViewFlowLayout()
        let viewController = PokedexListViewController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .overFullScreen
        PokedexListConfigurator.configureModule(viewController: viewController)
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
}
