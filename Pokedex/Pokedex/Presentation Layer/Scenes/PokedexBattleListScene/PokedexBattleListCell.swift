//
//  PokedexBattleListCell.swift
//  Pokedex
//
//  Created by durgesh-10379 on 13/09/21.
//

import UIKit

class PokedexBattleListCell: UITableViewCell {
    
    var pokemon: Pokemon? {
        didSet {
            nameLabel.text = pokemon?.name?.capitalized
            pokemonImageView.image = pokemon?.image
        }
    }
    
    
    let pokemonImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "defaultPokedexImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var nameContainerView: UIView = {
        let view = UIView()
        
        view.addSubview(nameLabel)
        nameLabel.center(inView: view)
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Bulbasaur"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureViewComponents() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        addSubview(pokemonImageView)
        pokemonImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        
        addSubview(nameContainerView)
        nameContainerView.anchor(top: topAnchor, left: pokemonImageView.leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 32)
        
    }
}
