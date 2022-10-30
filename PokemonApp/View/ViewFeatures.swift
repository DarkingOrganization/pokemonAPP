//
//  ViewFeatures.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 30/10/22.
//

import UIKit

class ViewFeatures: UIViewController {
    
    @IBOutlet weak private var element: UIImageView!
    @IBOutlet weak private var element2: UIImageView?
    @IBOutlet weak private var smallImage: UIButton!
    @IBOutlet weak private var bigImage: UIImageView!
    
    @IBOutlet weak private var namePokemonFeatures: UILabel!
    @IBOutlet weak private var codigoPokemonFeatures: UILabel!
    
    var pokemonSelect: PokemonModel? = nil
    
    override func viewDidLoad() {
        view.alpha = 0.5
        super.viewDidLoad()
        setupElement()
        
    }
    func setupElement() {
        if let pokemon = pokemonSelect {
            element.image = UIImage(named: pokemon.tipoPokemon)
            
            if let elemento = UIImage(named: pokemon.tipoPokemon2!) {
                element2?.image = elemento
            }
        }
    }
//    struct FunctionsPokemonSelect {
//        //MARK: - Funciones didselect
//        private func assignedStats(pokemonModel: [PokemonModel]?, indexPath: IndexPath, indexPokemon: PokemonModel) {
//            if let countStats = pokemonModel?[indexPath.row].stats.count {
//                for stat in 1...countStats {
//                    stats[stat - 1] = Float(indexPokemon.stats[stat - 1])
//                }
//            }
//        }
//    }
}




