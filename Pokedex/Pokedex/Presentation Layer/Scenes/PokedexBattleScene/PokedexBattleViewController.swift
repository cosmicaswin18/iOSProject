//
//  PokedexBattleViewController.swift
//  Pokedex
//
//  Created by durgesh-10379 on 08/09/21.
//

import UIKit

protocol PokedexBattlePresenterOutput: class {
    func presenter(selectFromList message: String)
    func presenter(backToPokedex message: String)
    func presenter(winnerIs pokemon: Pokemon)
}


class PokedexBattleViewController: UIViewController {
    
    var pokemon: Pokemon? {
        didSet {
            if BattleData1.isBattlePokemon == true {
                battleView.imageView1.image = pokemon?.image
                battleView.nameLabel1.text = pokemon?.name?.capitalized
                BattleData1.isBattlePokemon = false
                BattleData1.battlePokemon = pokemon
            } else if BattleData1.battlePokemon != nil {
                battleView.imageView1.image = BattleData1.battlePokemon?.image
                battleView.nameLabel1.text = BattleData1.battlePokemon?.name?.capitalized
            }
            if BattleData2.isBattlePokemon == true {
                battleView.imageView2.image = pokemon?.image
                battleView.nameLabel2.text = pokemon?.name?.capitalized
                BattleData2.isBattlePokemon = false
                BattleData2.battlePokemon = pokemon
            } else if BattleData2.battlePokemon != nil {
                battleView.imageView2.image = BattleData2.battlePokemon?.image
                battleView.nameLabel2.text = BattleData2.battlePokemon?.name?.capitalized
            }
        }
    }
    
    let battleView: PokedexBattleView = {
        let view = PokedexBattleView()
        view.configureBattleView()
        return view
    }()
    
    let battleWinView: PokedexBattleWinView = {
        let view = PokedexBattleWinView()
        view.backgroundColor = .mainPink()
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
    }
    
    var pokemonBattleView: PokedexBattleView!
    var interactor: PokedexBattleInteractor?
    var router: PokedexBattleRouter?
    
    func configureViewComponents() {
        battleView.selectAction = selectBattlePokemon
        battleView.battleAction = startBattle
        view.addSubview(battleView)
        battleView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .mainPink()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.title = "Battle"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Pokedex", style: .done, target: self, action: #selector(backToPokedex))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        visualEffectView.alpha = 0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        visualEffectView.addGestureRecognizer(gesture)
    }
    
    func battleWinnerView(withPokemon pokemon: Pokemon) {
        
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        battleView.tapGesture1.isEnabled = false
        battleView.tapGesture2.isEnabled = false
        battleView.battleButton.isEnabled = false
        
        view.addSubview(battleWinView)
        battleWinView.configureBattleWinView()
        battleWinView.battleWinnner(is: pokemon)
        battleWinView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width - 64, height: 200)
        battleWinView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        battleWinView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -44).isActive = true
        
        battleWinView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        battleWinView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.battleWinView.alpha = 1
            self.battleWinView.transform = .identity
        }
    }
    func dismissInfoView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.battleWinView.alpha = 0
            self.battleWinView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.battleWinView.removeFromSuperview()
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.battleView.tapGesture1.isEnabled = true
            self.battleView.tapGesture2.isEnabled = true
            self.battleView.battleButton.isEnabled = true
        }
    }
    
    @objc func backToPokedex() {
        interactor?.backToPokedex()
    }
    
    @objc func handleDismissal() {
        dismissInfoView()
    }
    
    func selectBattlePokemon() {
        interactor?.selectPokemonFromList()
    }
    
    func startBattle() {
        interactor?.battle(between: BattleData1.battlePokemon!, and: BattleData2.battlePokemon!)
    }
}


extension PokedexBattleViewController: PokedexBattlePresenterOutput {
    
    func presenter(selectFromList message: String) {
        self.router?.routeToSelectionList()
        print(message)
    }
    
    func presenter(backToPokedex message: String) {
        self.router?.routeToPokedexList()
        print(message)
    }
    
    func presenter(winnerIs pokemon: Pokemon) {
        self.battleWinnerView(withPokemon: pokemon)
    }
}
