//
//  Pokemon.swift
//  Pokedex
//
//  Created by durgesh-10379 on 25/08/21.
//

import UIKit

struct EvolutionChain {
    
    var evolutionArray: [[String: AnyObject]]?
    var evolutionIds = [Int]()
    
    init(evolutionArray: [[String: AnyObject]]?) {
        self.evolutionArray = evolutionArray
        self.evolutionIds = setEvolutionIds()
    }
    
    func setEvolutionIds() -> [Int] {
        var results = [Int]()
        
        evolutionArray?.forEach({ (dictionary) in
            if let idString = dictionary["id"] as? String {
                guard let id = Int(idString) else { return }
                if id <= 151 {
                    results.append(id)
                }
            }
        })
        return results
    }
}

struct BattleData1 {
    static var isBattlePokemon: Bool = false
    static var battlePokemon: Pokemon?
}

struct BattleData2 {
    static var isBattlePokemon: Bool = false
    static var battlePokemon: Pokemon?
}

struct BattleStats {
    static var isDraw: Bool?
    static var battleWin: Int? = 0
    static var battleLose: Int? = 0
    static var battleDraw: Int? = 0
    static var totalBattles: Int? = 0
}

class Pokemon {
    
    var name: String?
    var imageUrl: String?
    var image: UIImage?
    var id: Int?
    var weight: Int?
    var height: Int?
    var defense: Int?
    var attack: Int?
    var description1: String?
    var type: String?
    var evolutionChain: [[String: AnyObject]]?
    var evoArray: [Pokemon]?
    
    init(id: Int, dictionary: [String: AnyObject]) {
        
        self.id = id
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let imageUrl = dictionary["imageUrl"] as? String {
            self.imageUrl = imageUrl
        }
        
        if let weight = dictionary["weight"] as? Int {
            self.weight = weight
        }
        
        if let height = dictionary["height"] as? Int {
            self.height = height
        }
        
        if let defense = dictionary["defense"] as? Int {
            self.defense = defense
        }
        
        if let attack = dictionary["attack"] as? Int {
            self.attack = attack
        }
        
        if let description = dictionary["description"] as? String {
            self.description1 = description
        }
        
        if let type = dictionary["type"] as? String {
            self.type = type.capitalized
        }
        
        if let evolutionChain = dictionary["evolutionChain"] as? [[String: AnyObject]] {
            self.evolutionChain = evolutionChain
        }
        
    }
    
}