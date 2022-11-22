//
//  PokedexListRouter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 25/08/21.
//

import UIKit

protocol PokedexListRouter {
    var navigationController: UINavigationController? { get }
    
    func routeToDetail(with pokemon: Pokemon)
    func routeToBattle()
    func routeToLogin()
    func routeToUserInfo(with userInfo: AppUser)
}

class PokedexListRouterImplementation: PokedexListRouter {
    
    
    var navigationController: UINavigationController?
    
    func routeToDetail(with pokemon: Pokemon) {
        let controller = PokedexDetailViewController()
        controller.pokemon = pokemon
        PokedexDetailConfigurator.configureModule(pokemon: pokemon, viewController: controller)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func routeToBattle() {
        let controller = PokedexBattleViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .overFullScreen
        PokedexBattleConfigurator.configureModule(viewController: controller)
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func routeToLogin() {
        let viewController = PokedexLoginViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .overFullScreen
        PokedexLoginViewConfigurator.configureModule(viewController: viewController)
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func routeToUserInfo(with userInfo: AppUser) {
        let controller = PokedexUserInfoController()
        controller.userInfo = userInfo
        PokedexUserInfoConfigurator.configureModule(userInfo: userInfo, viewController: controller)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
