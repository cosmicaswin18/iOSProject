//
//  PokedexBattleView.swift
//  Pokedex
//
//  Created by durgesh-10379 on 08/09/21.
//

import UIKit

class PokedexBattleView: UIView {
    
    var selectAction: (() -> Void)?
    var battleAction: (() -> Void)?
    
    var tapGesture1 = UITapGestureRecognizer()
    var tapGesture2 = UITapGestureRecognizer()
    
    lazy var battleButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainPink()
        button.setTitle("Battle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBattle), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let imageView1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "PokedexBattleIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let nameLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Choose Trainer Pokemon"
        return label
    }()
    
    
    lazy var pokemonContainerView1: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPink()
        view.addSubview(imageView1)
        view.addSubview(nameLabel1)
        view.layer.cornerRadius = 5
        nameLabel1.center(inView: view)
        imageView1.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        return view
    }()
    
    let imageView2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "PokedexBattleIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let nameLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Choose Challenger Pokemon"
        return label
    }()
    
    lazy var pokemonContainerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPink()
        view.addSubview(imageView2)
        view.addSubview(nameLabel2)
        view.layer.cornerRadius = 5
        nameLabel2.center(inView: view)
        imageView2.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        return view
    }()
    
    
    
    @objc func handleTap1(_ sender: UITapGestureRecognizer) {
        BattleData1.isBattlePokemon = true
        selectAction?()
    }
    
    @objc func handleTap2(_ sender: UITapGestureRecognizer) {
        BattleData2.isBattlePokemon = true
        selectAction?()
    }
    
    @objc func handleBattle() {
        battleAction?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBattleView() {
        addSubview(battleButton)
        self.layer.masksToBounds = true
        
        tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleTap1(_:)))
        tapGesture1.numberOfTapsRequired = 1
        pokemonContainerView1.addGestureRecognizer(tapGesture1)
        pokemonContainerView1.isUserInteractionEnabled = true
        addSubview(pokemonContainerView1)
        pokemonContainerView1.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 50)
        
        tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(handleTap2(_:)))
        tapGesture2.numberOfTapsRequired = 1
        pokemonContainerView2.addGestureRecognizer(tapGesture2)
        pokemonContainerView2.isUserInteractionEnabled = true
        addSubview(pokemonContainerView2)
        pokemonContainerView2.anchor(top: pokemonContainerView1.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 50)
        
        battleButton.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 0)
        battleButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        battleButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}

class PokedexBattleWinView: UIView {
    
    func battleWinnner(is pokemon: Pokemon) {
        imageView.image = BattleStats.isDraw! ? UIImage(named: "PokedexBattleIcon") :  pokemon.image
        nameLabel.text = BattleStats.isDraw! ? "Battle" :  pokemon.name?.capitalized
        winnerLabel.text = BattleStats.isDraw! ? "Draw" : "Wins"
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "PokedexBattleIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "The battle is a draw"
        return label
    }()
    
    let winnerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 48)
        return label
    }()
    
    
    func configureBattleWinView() {
        
        backgroundColor = .mainPink()
        self.layer.masksToBounds = true
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 75)
        
        addSubview(nameLabel)
        nameLabel.center(inView: self)
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 110).isActive = true
        
        addSubview(winnerLabel)
        winnerLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
}
