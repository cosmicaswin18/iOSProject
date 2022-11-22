//
//  PokedexSignUpViewRouter.swift
//  Pokedex
//
//  Created by durgesh-10379 on 01/09/21.
//

import UIKit

protocol PokedexSignUpRouter: class {
    var navigationController: UINavigationController? { get }
}

class PokedexSignUpRouterImplementation: PokedexSignUpRouter {
    
    weak var navigationController: UINavigationController?
    
}
