//
//  PokemonBattleLogic.swift
//  Pokedex
//
//  Created by durgesh-10379 on 17/09/21.
//

import Foundation

class PokemonBattleLogic {
    
    static let shared = PokemonBattleLogic()
    
    func attackCalcByType(attack1: inout Int, type1: String, attack2: inout Int, type2: String) -> (attack1: Int, attack2: Int) {
        
        if type1 == "fire" {
            attack1 = fireType(type: type2, attack: &attack1)
        }
        if type2 == "fire" {
            attack2 = fireType(type: type1, attack: &attack2)
        }
        
        if type1 == "water" {
            attack1 = waterType(type: type2, attack: &attack1)
        }
        if type2 == "water" {
            attack2 = waterType(type: type1, attack: &attack2)
        }
        
        if type1 == "grass" {
            attack1 = grassType(type: type2, attack: &attack1)
        }
        if type2 == "grass" {
            attack2 = grassType(type: type1, attack: &attack2)
        }
        
        if type1 == "normal" {
            attack1 = normalType(type: type2, attack: &attack1)
        }
        if type2 == "normal" {
            attack2 = normalType(type: type1, attack: &attack2)
        }
        
        if type1 == "electric" {
            attack1 = electricType(type: type2, attack: &attack1)
        }
        if type2 == "electric" {
            attack2 = electricType(type: type1, attack: &attack2)
        }
        
        if type1 == "poison" {
            attack1 = poisonType(type: type2, attack: &attack1)
        }
        if type2 == "poison" {
            attack2 = poisonType(type: type1, attack: &attack2)
        }
        
        if type1 == "ice" {
            attack1 = iceType(type: type2, attack: &attack1)
        }
        if type2 == "ice" {
            attack2 = iceType(type: type1, attack: &attack2)
        }
        
        if type1 == "fighting" {
            attack1 = fightingType(type: type2, attack: &attack1)
        }
        if type2 == "fighting" {
            attack2 = fightingType(type: type1, attack: &attack2)
        }
        
        if type1 == "ground" {
            attack1 = groundType(type: type2, attack: &attack1)
        }
        if type2 == "ground" {
            attack2 = groundType(type: type1, attack: &attack2)
        }
        
        if type1 == "flying" {
            attack1 = flyingType(type: type2, attack: &attack1)
        }
        if type2 == "flying" {
            attack2 = flyingType(type: type1, attack: &attack2)
        }
        
        if type1 == "psychic" {
            attack1 = psychicType(type: type2, attack: &attack1)
        }
        if type2 == "psychic" {
            attack2 = psychicType(type: type1, attack: &attack2)
        }
        
        if type1 == "bug" {
            attack1 = bugType(type: type2, attack: &attack1)
        }
        if type2 == "bug" {
            attack2 = bugType(type: type1, attack: &attack2)
        }
        
        if type1 == "rock" {
            attack1 = rockType(type: type2, attack: &attack1)
        }
        if type2 == "rock" {
            attack2 = rockType(type: type1, attack: &attack2)
        }
        
        if type1 == "dragon" {
            attack1 = dragonType(type: type2, attack: &attack1)
        }
        if type2 == "dragon" {
            attack2 = dragonType(type: type1, attack: &attack2)
        }
        
        if type1 == "steel" {
            attack1 = steelType(type: type2, attack: &attack1)
        }
        if type2 == "steel" {
            attack2 = steelType(type: type1, attack: &attack2)
        }
        
        if type1 == "fairy" {
            attack1 = fairyType(type: type2, attack: &attack1)
        }
        if type2 == "fairy" {
            attack2 = fairyType(type: type1, attack: &attack2)
        }
        
        return (attack1, attack2)
    }
    
    func doubleAttack(attack: Int) -> Int{
        return attack * 2
    }
    
    func halfAttack(attack: Int) -> Int{
        return attack / 2
    }
    
    func zeroAttack(attack: Int) -> Int {
        return attack * 0
    }
    
    func fireType(type: String, attack: inout Int) -> Int {
        let fireTypeDouble = ["grass", "ice", "bug", "steel"]
        let fireTypeHalf = ["fire", "water", "rock", "dragon"]
        
        if fireTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if fireTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func waterType(type: String, attack: inout Int) -> Int {
        let waterTypeDouble = ["fire", "ground", "rock"]
        let waterTypeHalf = ["water", "grass", "dragon"]
        
        if waterTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if waterTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func grassType(type: String, attack: inout Int) -> Int {
        let grassTypeDouble = ["water", "ground", "rock"]
        let grassTypeHalf = ["fire", "grass", "poison", "flying", "bug", "dragon", "steel"]
        
        if grassTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if grassTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func normalType(type: String, attack: inout Int) -> Int {
        let normalTypeHalf = ["rock", "steel"]
        
        if normalTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func electricType(type: String, attack: inout Int) -> Int {
        let electricTypeDouble = ["water", "flying"]
        let electricTypeHalf = ["electric", "grass", "dragon"]
        let electricTypeZero = ["ground"]
        
        if electricTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if electricTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        } else if electricTypeZero.contains(type) {
            attack = zeroAttack(attack: attack)
        }
        
        return attack
    }
    
    func poisonType(type: String, attack: inout Int) -> Int {
        let poisonTypeDouble = ["grass", "fairy"]
        let poisonTypeHalf = ["poison", "ground", "rock"]
        let poisonTypeZero = ["steel"]
        
        if poisonTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if poisonTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        } else if poisonTypeZero.contains(type) {
            attack = zeroAttack(attack: attack)
        }
        
        return attack
    }
    
    func iceType(type: String, attack: inout Int) -> Int {
        let iceTypeDouble = ["grass", "ground", "flying", "dragon"]
        let iceTypeHalf = ["fire", "water", "ice", "steel"]
        
        if iceTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if iceTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func fightingType(type: String, attack: inout Int) -> Int {
        let fightingTypeDouble = ["normal", "ice", "rock", "steel"]
        let fightingTypeHalf = ["poison", "flying", "psychic", "bug", "fairy"]
        
        if fightingTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if fightingTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func groundType(type: String, attack: inout Int) -> Int {
        let groundTypeDouble = ["fire", "electric", "poison", "rock", "steel"]
        let groundTypeHalf = ["grass", "bug"]
        let groundTypeZero = ["flying"]
        
        if groundTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if groundTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        } else if groundTypeZero.contains(type) {
            attack = zeroAttack(attack: attack)
        }
        
        return attack
    }
    
    func flyingType(type: String, attack: inout Int) -> Int {
        let flyingTypeDouble = ["grass", "fighting", "bug"]
        let flyingTypeHalf = ["electric", "rock", "steel"]
        
        if flyingTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if flyingTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func psychicType(type: String, attack: inout Int) -> Int {
        let psychicTypeDouble = ["fighting", "poison"]
        let psychicTypeHalf = ["psychic", "steel"]
        
        if psychicTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if psychicTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func bugType(type: String, attack: inout Int) -> Int {
        let bugTypeDouble = ["grass", "psychic"]
        let bugTypeHalf = ["fire", "fighting", "poison", "flying", "steel", "fairy"]
        
        if bugTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if bugTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func rockType(type: String, attack: inout Int) -> Int {
        let rockTypeDouble = ["fire", "ice", "flying", "bug"]
        let rockTypeHalf = ["fighting", "ground", "steel"]
        
        if rockTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if rockTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func dragonType(type: String, attack: inout Int) -> Int {
        let dragonTypeDouble = ["dragon"]
        let dragonTypeHalf = ["steel"]
        let dragonTypeZero = ["fairy"]
        
        if dragonTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if dragonTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        } else if dragonTypeZero.contains(type) {
            attack = zeroAttack(attack: attack)
        }
        
        return attack
    }
    
    func steelType(type: String, attack: inout Int) -> Int {
        let steelTypeDouble = ["fire", "ice", "flying", "bug"]
        let steelTypeHalf = ["fighting", "ground", "steel"]
        
        if steelTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if steelTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
    func fairyType(type: String, attack: inout Int) -> Int {
        let fairyTypeDouble = ["fighting", "dragon"]
        let fairyTypeHalf = ["fire", "poison", "steel"]
        
        if fairyTypeDouble.contains(type) {
            attack = doubleAttack(attack: attack)
        } else if fairyTypeHalf.contains(type) {
            attack = halfAttack(attack: attack)
        }
        
        return attack
    }
    
}
