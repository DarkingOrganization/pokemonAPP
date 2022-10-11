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
    
    func fetchPokemon(pokemonCode: String) {
        let urlString = "\(pokemonURL)\(pokemonCode)/"
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
            var tipo2: String = ""
            if  decodedData.types.count > 0 {
                tipo2 = decodedData.types[1].type.name
            }
            
            let pokemon = PokemonModel(pokemonName: name, imageFront: imagenPokemon,  pokemonID: id, tipoPokemon: tipo, tipoPokemon2: tipo2)
            
            ///
            
            
            
            ///

            return pokemon
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

    
    func imagenRequest(with urlString: String){
            if let url = URL(string: urlString) {
                let session = URLSession(configuration: .default)
                let _ = session.dataTask(with: url) { [weak self] data, response, error in
                          let httpURLResponse = response as? HTTPURLResponse
                          if let error = error {
                            print(error.localizedDescription)
                          }
                    if httpURLResponse?.statusCode == 200 {
                                guard let data = data else { return }
                                let image = UIImage(data: data)

                        // ya puedes usar la imagen  normalmente te pide procesar en el hilo principal solo usa el DispatchQueue.main.async
                        self?.imageFinal = image!
                          }

                    }.resume()
    }

     }
    
}

