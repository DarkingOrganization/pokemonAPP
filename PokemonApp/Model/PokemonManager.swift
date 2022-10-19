import Foundation
import CoreLocation
import UIKit

protocol PokemonManagerDelegate {
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel)
    func didFailWithError(error: Error)
}

class PokemonManager {
    let pokemonURL = "https://pokeapi.co/api/v2/pokemon/"
    var imageFinal: UIImage?
    var delegate: PokemonManagerDelegate?
    var tipo2Decode: String?
    var stats = [0,1,2,3,4,5]
    var tipo2: String = ""
    
    func fetchPokemon(pokemonCode: String) {
        let urlString = "\(pokemonURL)\(pokemonCode)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let pokemon = self.parseJSON(safeData) {
                        self.delegate?.didUpdatePokemon(self, pokemon: pokemon)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ pokemonData: Data) -> PokemonModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PokemonData.self, from: pokemonData)
            
            let name = decodedData.forms[0].name
            let imagenPokemon = decodedData.sprites.other.home.front_default
            let codigo = decodedData.id
            let id = decodedData.idString(codigo)
            let tipo = decodedData.types[0].type.name
            let ability = decodedData.abilities[0].ability.name
            
            stats[0] = decodedData.stats[0].base_stat
            stats[1] = decodedData.stats[1].base_stat
            stats[2] = decodedData.stats[2].base_stat
            stats[3] = decodedData.stats[3].base_stat
            stats[4] = decodedData.stats[4].base_stat
            stats[5] = decodedData.stats[5].base_stat
            
            if  decodedData.types.count > 1 {
                tipo2 = decodedData.types[1].type.name
            }
            
            let pokemon = PokemonModel(pokemonName: name, imageFront: imagenPokemon,  pokemonID: id, tipoPokemon: tipo, abilityPokemon: ability, tipoPokemon2: tipo2, stats: stats)
            return pokemon
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

