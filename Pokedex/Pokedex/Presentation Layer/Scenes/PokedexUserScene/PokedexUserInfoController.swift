//
//  PokedexUserInfoController.swift
//  Pokedex
//
//  Created by durgesh-10379 on 28/09/21.
//

import UIKit

protocol PokedexUserInfoPresenterOutput: class {
    func presenter(didRetrieveUser userInfo: AppUser)
}

class PokedexUserInfoController: UIViewController {
    
    var userInfo: AppUser? {
        didSet {
            navigationItem.title = userInfo?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        self.interactor?.viewDidLoadUser(with: userInfo!)
    }
    
    var userInfoView: PokedexUserInfo?
    var interactor: PokedexUserInfoInteractor?
    weak var presenter: PokedexUserInfoPresenter?
    var router: PokedexUserInfoRouter?
    
    var userView: PokedexUserInfo = {
        let view = PokedexUserInfo()
        view.configureUserComponents()
        return view
    }()
    
    func configureViewComponents() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(userView)
        userView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
}

extension PokedexUserInfoController: PokedexUserInfoPresenterOutput {
    
    func presenter(didRetrieveUser userInfo: AppUser) {
        userView.userInfo(with: userInfo)
    }
    
}
