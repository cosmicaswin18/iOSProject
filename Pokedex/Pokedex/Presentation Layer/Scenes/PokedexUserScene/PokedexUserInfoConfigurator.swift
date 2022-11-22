//
//  PokedexUserInfoConfigurator.swift
//  Pokedex
//
//  Created by durgesh-10379 on 28/09/21.
//

import Foundation

class PokedexUserInfoConfigurator {
    
    static func configureModule(userInfo: AppUser, viewController: PokedexUserInfoController)
    {
        let view = PokedexUserInfo()
        let router = PokedexUserInfoRouterImplementation()
        let interactor = PokedexUserInfoInteractorImplementation()
        let presenter = PokedexUserInfoPresenterImplementation()
        
        
        viewController.userInfoView = view
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
    }
}
