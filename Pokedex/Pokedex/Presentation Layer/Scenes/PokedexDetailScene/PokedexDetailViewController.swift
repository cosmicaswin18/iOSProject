//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by durgesh-10379 on 26/08/21.
//

import UIKit

protocol PokedexDetailPresenterOutput: class {
    func presenter(didRetrievePokemon pokemon: Pokemon)
}

class PokedexDetailViewController: UIViewController {
    
    var pokemon: Pokemon? {
        didSet {
            navigationItem.title = pokemon?.name?.capitalized
            detailView.imageView.image = pokemon?.image
            detailView.detailLabel.text = pokemon?.description1
            detailView.poke = pokemon
            
            if let evoArray = pokemon?.evoArray {
                if evoArray.count > 1 {
                    detailView.firstEvoImageView.image = evoArray[0].image
                    detailView.secondEvoImageView.image = evoArray[1].image
                } else {
                    detailView.firstEvoImageView.image = evoArray[0].image
                }
            }
        }
    }
    
    let detailView: PokedexDetailView = {
        let view = PokedexDetailView()
        view.configureViewForInfoController()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        self.interactor?.viewDidLoadPokemon(with: pokemon!)
    }
    
    var pokemonDetailView: PokedexDetailView?
    var interactor: PokedexDetailInteracor?
    weak var presenter: PokedexDetailPresenter?
    var router: PokedexDetailRouter?
    
    func configureViewComponents() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(detailView.imageView)
        detailView.imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 44, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        
        view.addSubview(detailView.detailLabel)
        detailView.detailLabel.anchor(top: nil, left: detailView.imageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 44, paddingLeft: 16, paddingBottom: 0, paddingRight: 4, width: 0, height: 0)
        detailView.detailLabel.centerYAnchor.constraint(equalTo: detailView.imageView.centerYAnchor).isActive = true
        
        view.addSubview(detailView)
        detailView.anchor(top: detailView.detailLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        view.addSubview(detailView.evolutionView)
        detailView.evolutionView.anchor(top: detailView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        view.addSubview(detailView.firstEvoImageView)
        detailView.firstEvoImageView.anchor(top: detailView.evolutionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        
        view.addSubview(detailView.secondEvoImageView)
        detailView.secondEvoImageView.anchor(top: detailView.evolutionView.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 32, width: 120, height: 120)
        
    }
}

extension PokedexDetailViewController: PokedexDetailPresenterOutput {
    
    func presenter(didRetrievePokemon pokemon: Pokemon) {
        detailView.selectPokemon(with: pokemon)
    }
}
