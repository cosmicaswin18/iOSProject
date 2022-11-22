//
//  PokedexBattleListController.swift
//  Pokedex
//
//  Created by durgesh-10379 on 13/09/21.
//

import UIKit


private let reuseIdentifier = "TableViewCell"

protocol PokedexBattleListPresenterOutput {
    func presenter(didSelectPokemon pokemon: Pokemon)
}

class PokedexBattleListController: UITableViewController {
    
    var pokedexBattleListCell: PokedexBattleListCell?
    var interactor: PokedexBattleListInteractor?
    var router: PokedexBattleListRouter?
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var searchBar: UISearchBar!
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .mainPink()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        fetchPokemon()
        configureViewComponents()
    }
    
    func fetchPokemon() {
        PokemonAPI.shared.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func configureViewComponents() {
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        navigationController?.navigationBar.barTintColor = .mainPink()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Select From List"
        
        configureSearchBarButton()
        
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 75
        tableView.estimatedRowHeight = 75
        tableView.register(PokedexBattleListCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    @objc func showSearchBar() {
        configureSearchBar(shouldShow: true)
    }
    
    @objc func dismissView() {
        if BattleData1.isBattlePokemon == true || BattleData2.isBattlePokemon == true {
            BattleData1.isBattlePokemon = false
            BattleData2.isBattlePokemon = false
        }
        dismiss(animated: true, completion: nil)
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
            navigationItem.leftBarButtonItem = nil
            navigationItem.titleView = searchBar
            
        } else {
            navigationItem.titleView = nil
            configureSearchBarButton()
            inSearchMode = false
            tableView.reloadData()
        }
    }
    
    func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationItem.leftBarButtonItem?.title = "Dismiss"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
}

extension PokedexBattleListController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        configureSearchBar(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            filteredPokemon = pokemon.filter({ $0.name?.range(of: searchText.lowercased()) != nil })
            tableView.reloadData()
        }
    }
}

extension PokedexBattleListController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredPokemon.count : pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! PokedexBattleListCell
        cell.pokemon = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let poke = inSearchMode ? filteredPokemon[indexPath.row] : pokemon[indexPath.row]
        interactor?.selectPokemon(with: poke)
    }
}

extension PokedexBattleListController: PokedexBattleListPresenterOutput {
    
    func presenter(didSelectPokemon pokemon: Pokemon) {
        self.router?.routeToBattle(pokemon: pokemon)
    }
}
