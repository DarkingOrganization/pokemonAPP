import UIKit

struct FunctionsPokemonSelect {
    
    var codigoImagenPokemon:String?
    var pokemonModel: [PokemonModel?]
    
    init(_ codigoImagenPokemon: String?,_ pokemonModel: [PokemonModel?]) {
        self.codigoImagenPokemon = codigoImagenPokemon
        self.pokemonModel = pokemonModel
    }
    //MARK: - Image Names
    func renameImagenAssets(imagen: Int) -> String? {
        if imagen < 10 {
            return "00\(String(imagen))"
        } else if imagen < 100 {
            return "0\(String(imagen))"
        } else if imagen < 810 {
            return "\(String(imagen))"
        } else {
            return "nil"
        }
    }
    //MARK: - Update cell data
    mutating func updateTipoImagePokemonCell(pokemon: [PokemonModel?]) {
        func setupTipoPokemon(_ indexPath: IndexPath,_ cell: PokemonCell) {
            if let tipo = pokemon[indexPath.row]?.tipoPokemon {
                cell.imageClaseOne.image = UIImage(named: tipo)
            }
            if let tipo2 = pokemon[indexPath.row]?.tipoPokemon2 {
                cell.imageClaseTwo.image = UIImage(named: tipo2)
            }
        }
    }
    mutating func setupImagenPokemon(_ indexPath: IndexPath,_ cell: PokemonCell) {
        if let imagenPokemon = Int((self.pokemonModel[indexPath.row]?.pokemonID)!) {
            self.codigoImagenPokemon = renameImagenAssets(imagen: imagenPokemon)
            
            if let codigo = codigoImagenPokemon {
                cell.pokemonImage.image = UIImage(named: codigo)
            }
        }
    }
}
