import UIKit

public struct PokemonModel {
    public var pokemonName: String
    public let imageFront: String
    public let pokemonID: String
    public let tipoPokemon: String
    public let abilityPokemon: String
    public let tipoPokemon2: String?
    public var stats: [Int]
    
    public init(_ pokemonName: String, _ imageFront: String, _ pokemonID: String, _ tipoPokemon: String, _ abilityPokemon: String, _ tipoPokemon2: String?, _ stats: [Int]) {
        self.pokemonName = pokemonName
        self.imageFront = imageFront
        self.pokemonID = pokemonID
        self.tipoPokemon = tipoPokemon
        self.abilityPokemon = abilityPokemon
        self.tipoPokemon2 = tipoPokemon2
        self.stats = stats
    }
}
