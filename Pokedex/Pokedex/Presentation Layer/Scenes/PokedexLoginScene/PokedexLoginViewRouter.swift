//
//  PokedexLoginViewRouter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 30/08/21.
//

import UIKit

protocol PokedexLoginViewRouter: class {
    var navigationController: UINavigationController? { get }
    func routeToSignUp()
    func routeToPokedexList()
}

class PokedexLoginViewRouterImplementation: PokedexLoginViewRouter {
    
    weak var navigationController: UINavigationController?
    
    func routeToSignUp() {
        let viewController = PokedexSignUpController()
        viewController.modalPresentationStyle = .overFullScreen
        PokedexSignUpConfigurator.configureModule(viewController: viewController)
        navigationController?.present(viewController, animated: true, completion: nil)
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
