//
//  PokemonManager.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 7/10/22.
//

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
            
//            let id = decodedData.weather[0].id
//            let temp = decodedData.main.temp
            let name = decodedData.forms[0].name
            let imagenPokemon = decodedData.sprites.other.home.front_default
            let codigo = decodedData.id
            let id = decodedData.idString(codigo)
            let tipo = decodedData.types[0].type.name
            let ability = decodedData.abilities[0].ability.name
            
            var stats = [0,1,2,3,4,5]
            
            let stats1 = decodedData.stats[0].base_stat
            let stats2 = decodedData.stats[1].base_stat
            let stats3 = decodedData.stats[2].base_stat
            let stats4 = decodedData.stats[3].base_stat
            let stats5 = decodedData.stats[4].base_stat
            let stats6 = decodedData.stats[5].base_stat
            
            _ = {
                    func decodeRange (_ indexPath: IndexPath) -> String? {
                            let tipo = decodedData.types[indexPath.row].type.name
                        self.tipo2Decode = tipo
                    return tipo
                }
            }
   
            stats[0] = stats1
            stats[1] = stats2
            stats[2] = stats3
            stats[3] = stats4
            stats[4] = stats5
            stats[5] = stats6

            let pokemon = PokemonModel(pokemonName: name, imageFront: imagenPokemon,  pokemonID: id, tipoPokemon: tipo, abilityPokemon: ability, tipoPokemon2: tipo2Decode, stats: stats)//


            return pokemon
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

    
}

