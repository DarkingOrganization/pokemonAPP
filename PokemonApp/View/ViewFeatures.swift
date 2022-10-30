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
    @IBOutlet weak private var codigoImagenPokemon: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var functionsPokemonSelect = FunctionsPokemonSelect()
    var pokemonSelect: PokemonModel? = nil
    
    override func viewDidLoad() {
        closeButton.alpha = 0.5
        view.alpha = 0.5
        super.viewDidLoad()
        setupElement()
        setupImagenPokemon()
    }

    func setupElement() {
        if let pokemon = pokemonSelect {
            element.image = UIImage(named: pokemon.tipoPokemon)
            if let elemento = UIImage(named: pokemon.tipoPokemon2!) {
                element2?.image = elemento
            }
        }
    }
    func setupImagenPokemon() {
        if let imagenPokemon = Int(pokemonSelect!.pokemonID) {
            self.codigoImagenPokemon.text = functionsPokemonSelect.renameImagenAssets(imagen: imagenPokemon)

            if let codigo = codigoImagenPokemon.text {
                bigImage.image = UIImage(named: codigo)
                smallImage.setImage(UIImage(named: codigo), for: .normal)
            }
        }
    }
    func setupNamePokemon() {
        if let namePokemon = pokemonSelect?.pokemonName {
        self.namePokemonFeatures.text = namePokemon
    }
    }
    @IBAction func closeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}




