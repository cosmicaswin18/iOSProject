//
//  PokedexDetailView.swift
//  Pokedex
//
//  Created by durgesh-10379 on 26/08/21.
//

import UIKit

protocol PokedexDetailViewDelegate {
    func dismissPokedexDetailView(withPokemon pokemon: Pokemon?)
}

class PokedexDetailView: UIView {
    
    var delegate: PokedexDetailViewDelegate?
    var poke: Pokemon?
    
    lazy var tapGesture1 = UITapGestureRecognizer()
    lazy var tapGesture2 = UITapGestureRecognizer()
    
    func selectPokemon(with pokemon: Pokemon) {
        self.poke = pokemon
        guard let type = pokemon.type else { return }
        guard let defense = pokemon.defense else { return }
        guard let attack = pokemon.attack else { return }
        guard let id = pokemon.id else { return }
        guard let height = pokemon.height else { return }
        guard let weight = pokemon.weight else { return }
        
        imageInfoView.image = pokemon.image
        nameLabel.text = pokemon.name?.capitalized
        
        configureLabel(label: typeLabel, title: "Type", details: type)
        configureLabel(label: defenseLabel, title: "Defense", details: "\(defense)")
        configureLabel(label: heightLabel, title: "Height", details: "\(height)")
        configureLabel(label: weightLabel, title: "Weight", details: "\(weight)")
        configureLabel(label: pokedexIdLabel, title: "Pokedex Id", details: "\(id)")
        configureLabel(label: attackLabel, title: "Attack", details: "\(attack)")
    }
    
    let imageInfoView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var nameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPink()
        view.addSubview(nameLabel)
        view.layer.cornerRadius = 5
        nameLabel.center(inView: view)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Charmander"
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let defenseLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let pokedexIdLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let attackLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainPink()
        button.setTitle("View More Info", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleViewMoreInfo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
     lazy var evolutionView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPink()
        
        view.addSubview(evoLabel)
        evoLabel.translatesAutoresizingMaskIntoConstraints = false
        evoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        evoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    let evoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Evolution Chain"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let firstEvoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    let secondEvoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleViewMoreInfo() {
        guard let pokemon = self.poke else { return }
        delegate?.dismissPokedexDetailView(withPokemon: pokemon)
    }
    
    @objc func handleTap1(_ sender: UITapGestureRecognizer) {
        firstEvoImageView.isHidden = false
        secondEvoImageView.isHidden = false
        
    }
    
    @objc func handleTap2(_ sender: UITapGestureRecognizer) {
        firstEvoImageView.isHidden = true
        secondEvoImageView.isHidden = true
        
    }
    
    func configureLabel(label: UILabel, title: String, details: String) {
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(title):  ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainPink()]))
        attributedText.append(NSAttributedString(string: "\(details)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.black]))
        label.attributedText = attributedText
    }
    
    func configureViewForInfoController() {
        addSubview(typeLabel)
        typeLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(defenseLabel)
        defenseLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .mainPink()
        addSubview(separatorView)
        separatorView.anchor(top: typeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 1)
        
        addSubview(heightLabel)
        heightLabel.anchor(top: separatorView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(weightLabel)
        weightLabel.anchor(top: heightLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(pokedexIdLabel)
        pokedexIdLabel.anchor(top: separatorView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        addSubview(attackLabel)
        attackLabel.anchor(top: pokedexIdLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleTap1(_:)))
        tapGesture1.numberOfTapsRequired = 1
        evolutionView.addGestureRecognizer(tapGesture1)
        tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(handleTap2(_:)))
        tapGesture2.numberOfTapsRequired = 2
        evolutionView.addGestureRecognizer(tapGesture2)
        evolutionView.isUserInteractionEnabled = true
    }
    
    func configureViewComponents() {
        
        backgroundColor = .white
        self.layer.masksToBounds = true
        
        addSubview(nameContainerView)
        nameContainerView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        addSubview(imageInfoView)
        imageInfoView.anchor(top: nameContainerView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 60)
        imageInfoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(typeLabel)
        typeLabel.anchor(top: imageInfoView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(defenseLabel)
        defenseLabel.anchor(top: imageInfoView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .mainPink()
        addSubview(separatorView)
        separatorView.anchor(top: typeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 1)
        
        addSubview(heightLabel)
        heightLabel.anchor(top: separatorView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(weightLabel)
        weightLabel.anchor(top: heightLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(pokedexIdLabel)
        pokedexIdLabel.anchor(top: separatorView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        addSubview(attackLabel)
        attackLabel.anchor(top: pokedexIdLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        addSubview(infoButton)
        infoButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 50)
    }
}
