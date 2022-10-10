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
    var id: Int
    
    
    func idString (_ code: Int) -> String {
        return "00\(code)"
    }
    
}
struct forms: Codable {
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


