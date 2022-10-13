//
//  PokemonData.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 7/10/22.
//

import Foundation

struct PokemonData: Codable {
    let forms: [forms]
    let sprites: Sprites
    let id: Int
    var types: [Types] ///= [.init(type: Name(name: "")), .init(type: Name(name: ""))]
    var abilities: [Abilities]
    
    func idString (_ code: Int) -> String {
        return "00\(code)"
    }
    
}

struct Abilities: Codable  {
    let  ability: ability
}

struct ability: Codable  {
    let name: String
    let url: URL
}
struct forms: Codable {
    let name: String
}

struct Types: Codable {
    let type: Name
}

struct Name: Codable {
   let name: String
}

struct Sprites: Codable {
    let other: Other
}
struct Other: Codable {
    let home: Home
}

//sprites.other.home.front_default

struct Home: Codable {
    let front_default: String
}


