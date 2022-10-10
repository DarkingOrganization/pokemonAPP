//
//  TableViewCell.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 8/10/22.
//

import UIKit


import UIKit
class TableViewCell: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var TableViewCell: UITableView!
    private var pokemonManager = PokemonManager()
    var pokemones: [PokemonModel]? = [PokemonModel(pokemonName: "Mi name", imageFront: .checkmark, pokemonID: "008")]// []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewCell.dataSource = self
        TableViewCell.delegate = self
        pokemonManager.delegate = self
        TableViewCell.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    
        
        loaditems()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "features", sender: self)
    }

    func loaditems() {
        TableViewCell.reloadData()
    }
}

extension TableViewCell: PokemonManagerDelegate {
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel) {
        DispatchQueue.main.async {
            
        let pokemoncito: [PokemonModel] = [PokemonModel(pokemonName: pokemon.pokemonName, imageFront: pokemon.imageFront, pokemonID: pokemon.pokemonID)]
        self.pokemones?.append(contentsOf: pokemoncito)
        self.TableViewCell.reloadData()
    }
    }
    func didFailWithError(error: Error) {
        print(error)
    }

}

extension TableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! PokemonCell
        
//        if let imagenExiste = UIImage(contentsOfFile: selectPokemon[indexPath.row].pokemonImage!) {
//            cell.buttonPokemon.setImage(imagenExiste, for: .normal)
//        }
        
        cell.pokemonLabel.text = "pokemones?[indexPath.row].pokemonName"
        
     //   cell.buttonPokemon.imageView = selectPokemon[indexPath.row].pokemonImage
     
//        @IBOutlet weak var buttonPokemon: UIButton!
//        @IBOutlet weak var namePokemon: UILabel!
//        @IBOutlet weak var codePokemon: UILabel!
//        @IBOutlet weak var elementPokemon: UIImageView!
//        @IBOutlet weak var featuresPokemon: UIImageView!
        
        return cell
    }

}

