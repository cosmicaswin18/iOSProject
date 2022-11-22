//
//  PokedexListViewController.swift
//  Pokedex
//
//  Created by durgesh-10379 on 25/08/21.
//

import UIKit

private let reuseIdentifier = "PokedexCell"

protocol PokedexListPresenterOutput: class {
    func presenter(didObtainPokemon pokemon: Pokemon)
    func presenter(filteredPokemons pokemon: [Pokemon], with type: String)
    func presenter(userInfo user: AppUser?)
    func presenter(battleScreen message: String)
    func presenter(logoutSuccess message: String)
    func presenter(logoutFailure message: String)
}

class PokedexListViewController: UICollectionViewController {
    
    var pokedexCell: PokedexListCell?
    var interactor: PokedexListInteractor?
    var router: PokedexListRouter?
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var searchBar: UISearchBar!
    var appUserName: String?
    var appUser: AppUser? {
        didSet {
            guard let username = appUser?.name else { return }
            appUserName = username
        }
    }
    
    let detailView: PokedexDetailView = {
        let view = PokedexDetailView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    
    let userInfoVisualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    
    var userInfoView: PokedexUserInfo = {
        let view = PokedexUserInfo()
        view.layer.cornerRadius = 5
        return view
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .mainPink()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        configureViewComponents()
        fetchPokemon()
        setupButton()
    }
    
    @objc func showSearchBar() {
        configureSearchBar(shouldShow: true)
    }
    
    @objc func handleDismissal() {
        dismissInfoView(pokemon: nil)
    }
    
    func fetchPokemon() {
        PokemonAPI.shared.fetchPokemon{ (pokemon) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func setupButton() {
        let actionMenu = UIMenu(title: "Options", options: .displayInline, children: [
            UIAction(title: "Logout", image: UIImage(systemName: "power")) { action in
                self.interactor?.logout()
            },
            
            UIAction(title: "Filter by type", image: UIImage(systemName: "slider.horizontal.3")) { action in
                self.filterAlertBox()
            },
            
            UIAction(title: "Battle Scene", image: UIImage(named: "PokedexBattleIcon")) { action in
                self.interactor?.battleScreen()
            },
            
            UIAction(title: "User Info", image: UIImage(systemName: "person.fill")) { action in
                self.interactor?.fetchUserInfo()
            }
        ])
        
        let actionButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .mainPink()
            button.layer.cornerRadius = 25
            button.clipsToBounds = true
            button.contentMode = .scaleAspectFill
            button.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
            button.tintColor = .white
            button.layer.borderColor = UIColor.mainPink().cgColor
            button.setTitleColor(.black, for: .normal)
            button.menu = actionMenu
            button.showsMenuAsPrimaryAction = true
            return button
        }()
        
        
        view.addSubview(actionButton)
        actionButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 50, paddingRight: 25, width: 50, height: 50)
        
    }
    
    func filterAlertBox() {
        //        let filterAlert = UIAlertController(title: "Filter by Pokemon Type", message: nil, preferredStyle: .alert)
        //
        //        filterAlert.addTextField { (textField) in
        //            textField.placeholder = "Pokemon Type"
        //        }
        //
        //        let filterAction = UIAlertAction(title: "Filter", style: .default) { [self] (action) in
        //            let pokemonType = filterAlert.textFields?.first?.text ?? ""
        //            self.interactor?.filterPokemon(with: pokemonType, from: pokemon)
        //        }
        //
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //
        //        filterAlert.addAction(filterAction)
        //        filterAlert.addAction(cancelAction)
        //
        //        present(filterAlert, animated: true, completion: nil)
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let fireAction = UIAlertAction(title: "Fire", style: .default, handler:
                                        {
                                            (alert: UIAlertAction!) -> Void in
                                            self.interactor?.filterPokemon(with: "fire", from: self.pokemon)
                                        })
        
        let waterAction = UIAlertAction(title: "Water", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "water", from: self.pokemon)
                                            })
        
        let grassAction = UIAlertAction(title: "Grass", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "grass", from: self.pokemon)
                                            })
        
        let normalAction = UIAlertAction(title: "Normal", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "normal", from: self.pokemon)
                                            })
        
        let electricAction = UIAlertAction(title: "Electric", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "electric", from: self.pokemon)
                                            })
        
        let poisonAction = UIAlertAction(title: "Poison", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "poison", from: self.pokemon)
                                            })
        
        let iceAction = UIAlertAction(title: "Ice", style: .default, handler:
                                        {
                                            (alert: UIAlertAction!) -> Void in
                                            self.interactor?.filterPokemon(with: "ice", from: self.pokemon)
                                        })
        
        let fightingAction = UIAlertAction(title: "Fighting", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "Fighting", from: self.pokemon)
                                            })
        
        let groundAction = UIAlertAction(title: "Ground", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "Ground", from: self.pokemon)
                                            })
        
        let flyingAction = UIAlertAction(title: "Flying", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "flying", from: self.pokemon)
                                            })
        
        let psychicAction = UIAlertAction(title: "Psychic", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "psychic", from: self.pokemon)
                                            })
        
        let bugAction = UIAlertAction(title: "Bug", style: .default, handler:
                                        {
                                            (alert: UIAlertAction!) -> Void in
                                            self.interactor?.filterPokemon(with: "bug", from: self.pokemon)
                                        })
        
        let rockAction = UIAlertAction(title: "Rock", style: .default, handler:
                                        {
                                            (alert: UIAlertAction!) -> Void in
                                            self.interactor?.filterPokemon(with: "rock", from: self.pokemon)
                                        })
        
        let dragonAction = UIAlertAction(title: "Dragon", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "dragon", from: self.pokemon)
                                            })
        
        let steelAction = UIAlertAction(title: "Steel", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "steel", from: self.pokemon)
                                            })
        
        let fairyAction = UIAlertAction(title: "Fairy", style: .default, handler:
                                            {
                                                (alert: UIAlertAction!) -> Void in
                                                self.interactor?.filterPokemon(with: "Fairy", from: self.pokemon)
                                            })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        optionMenu.addAction(fireAction)
        optionMenu.addAction(waterAction)
        optionMenu.addAction(grassAction)
        optionMenu.addAction(normalAction)
        optionMenu.addAction(electricAction)
        optionMenu.addAction(poisonAction)
        optionMenu.addAction(iceAction)
        optionMenu.addAction(fightingAction)
        optionMenu.addAction(groundAction)
        optionMenu.addAction(flyingAction)
        optionMenu.addAction(psychicAction)
        optionMenu.addAction(bugAction)
        optionMenu.addAction(rockAction)
        optionMenu.addAction(dragonAction)
        optionMenu.addAction(steelAction)
        optionMenu.addAction(fairyAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func configureSearchBar(shouldShow: Bool) {
        
        if shouldShow {
            let searchBar = SearchBar()
            searchBar.delegate = self
            searchBar.sizeToFit()
            searchBar.showsCancelButton = true
            searchBar.becomeFirstResponder()
            searchBar.tintColor = .white
            
            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchBar
            
        } else {
            navigationItem.titleView = nil
            configureSearchBarButton()
            inSearchMode = false
            navigationItem.title = "Pokedex"
            collectionView.reloadData()
        }
    }
    
    func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func dismissInfoView(pokemon: Pokemon?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.detailView.alpha = 0
            self.detailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.detailView.removeFromSuperview()
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            guard let pokemon = pokemon else { return }
            self.interactor?.selectPokemon(with: pokemon)
        }
    }
    
    
    @objc func cancelButton() {
        configureSearchBar(shouldShow: false)
    }
    
    func configureViewComponents() {
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        collectionView.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: appUserName ,style: .done, target: self, action: .none)
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        navigationController?.navigationBar.barTintColor = .mainPink()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.title = "Pokedex"
        
        configureSearchBarButton()
        
        collectionView.register(PokedexListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        visualEffectView.alpha = 0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        visualEffectView.addGestureRecognizer(gesture)
        
    }
}

extension PokedexListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        configureSearchBar(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            filteredPokemon = pokemon.filter({ $0.name?.range(of: searchText.lowercased()) != nil })
            collectionView.reloadData()
        }
    }
}

extension PokedexListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredPokemon.count : pokemon.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokedexListCell
        
        cell.pokemon = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        
        var pokemonEvoArray = [Pokemon]()
        
        if let evoChain = poke.evolutionChain {
            let evolutionChain = EvolutionChain(evolutionArray: evoChain)
            let evoIds = evolutionChain.evolutionIds
            
            evoIds.forEach { (id) in
                pokemonEvoArray.append(pokemon[id - 1])
            }
            poke.evoArray = pokemonEvoArray
        }
        interactor?.selectPokemon(with : poke)
    }
}

extension PokedexListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 36 ) / 3
        return CGSize(width: width, height: width)
    }
}

extension PokedexListViewController: PokedexCellDelegate {
    
    func presentInfoView(withPokemon pokemon: Pokemon) {
        
        configureSearchBar(shouldShow: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(detailView)
        detailView.configureViewComponents()
        detailView.delegate = self
        detailView.selectPokemon(with: pokemon)
        detailView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width - 64, height: 350)
        detailView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -44).isActive = true
        
        detailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        detailView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.detailView.alpha = 1
            self.detailView.transform = .identity
        }
    }
}

extension PokedexListViewController: PokedexDetailViewDelegate {
    
    func dismissPokedexDetailView(withPokemon pokemon: Pokemon?) {
        dismissInfoView(pokemon: pokemon)
    }
}

extension PokedexListViewController: PokedexListPresenterOutput {
    
    func presenter(didObtainPokemon pokemon: Pokemon) {
        self.router?.routeToDetail(with: pokemon)
    }
    
    func presenter(filteredPokemons pokemon: [Pokemon], with type: String) {
        inSearchMode = true
        filteredPokemon = pokemon
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.title = "\(type.capitalized) Pokemon"
        collectionView.reloadData()
    }
    
    func presenter(userInfo user: AppUser?) {
        self.appUser = user
        self.router?.routeToUserInfo(with: user!)
    }
    
    func presenter(battleScreen message: String) {
        print(message)
        self.router?.routeToBattle()
    }
    
    func presenter(logoutSuccess message: String) {
        print(message)
        self.router?.routeToLogin()
    }
    
    func presenter(logoutFailure message: String) {
        let alert = UIAlertController(title: "Logout Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
