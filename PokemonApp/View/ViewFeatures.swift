//
//  ViewFeatures.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 30/10/22.
//

import UIKit

class ViewFeatures: UIViewController {
    
    @IBOutlet weak private var element2: UIImageView?
    @IBOutlet weak private var element: UIImageView!
    @IBOutlet weak private var smallImage: UIButton!
    @IBOutlet weak private var bigImage: UIImageView!
    
    @IBOutlet weak private var namePokemonFeatures: UILabel!
    @IBOutlet weak private var codigoImagenPokemon: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var stackView: UIView!
    
    var pokemonSelect: PokemonModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.alpha = 0.5
        closeButton.backgroundColor = .white
        view.alpha = 1
        stackView.layer.borderColor = .init(genericCMYKCyan: 60, magenta: 60, yellow: 60, black: 60, alpha: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupElement()
        setupImagenPokemon()
        setupNamePokemon()
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
        let functionsPokemonSelect = FunctionsPokemonSelect(codigoImagenPokemon.text, [pokemonSelect])
        if let codigoImagenPokemon = functionsPokemonSelect.renameImagenAssets(imagen: Int(pokemonSelect!.pokemonID)!) {
            self.codigoImagenPokemon.text = "#\(codigoImagenPokemon)"
            bigImage.image = UIImage(named: codigoImagenPokemon)
            smallImage.setImage(UIImage(named: codigoImagenPokemon), for: .normal)
        }
    }
    func setupNamePokemon() {
        if let namePokemon = pokemonSelect?.pokemonName {
            self.namePokemonFeatures.text = namePokemon
        }
    }
    @IBAction func closeButton(_ sender: Any) {
        // navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}




