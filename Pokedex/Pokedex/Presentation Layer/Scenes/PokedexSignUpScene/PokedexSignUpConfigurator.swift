//
//  PokedexSignUpViewConfigurator.swift
//  Pokedex
//
//  Created by durgesh-10379 on 01/09/21.
//

import Foundation

class PokedexSignUpConfigurator {
    
    static func configureModule(viewController: PokedexSignUpController) {
        let view = PokedexSignUpView()
        let router = PokedexSignUpRouterImplementation()
        let interactor = PokedexSignUpInteractorImplementation()
        let presenter = PokedexSignUpPresenterImplementation()
        
        viewController.signUpView = view
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
    }
}
