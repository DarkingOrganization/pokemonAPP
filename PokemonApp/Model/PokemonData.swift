import Foundation

struct PokemonData: Codable {
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

struct Stats: Codable {
    let base_stat: Int
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

struct Home: Codable {
    let front_default: String
}
