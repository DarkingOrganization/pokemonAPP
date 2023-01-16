
import Foundation

public struct PokemonData: Codable {
    let forms: [forms]
    let sprites: Sprites
    let id: Int
    var types: [Types]
    var abilities: [Abilities]
    var stats: [Stats]
    func idString (_ code: Int) -> String {
        return "00\(code)"
    }
}

public struct Stats: Codable {
    let base_stat: Int
}

public struct Abilities: Codable  {
    let  ability: ability
}

public struct ability: Codable  {
    let name: String
    let url: URL
}
public struct forms: Codable {
    let name: String
}

public struct Types: Codable {
    let type: Name
}

public struct Name: Codable {
    let name: String
}

public struct Sprites: Codable {
    let other: Other
}
public struct Other: Codable {
    let home: Home
}

public struct Home: Codable {
    let front_default: String
}
