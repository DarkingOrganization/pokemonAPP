//
//  PokemonCell.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 7/10/22.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var codigoPokemonLabel: UILabel!
    
    @IBOutlet weak var imageClaseOne: UIImageView!
    @IBOutlet weak var imageClaseTwo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // pokemonImage.image = "
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        contentView.backgroundColor = UIColor.white
       
    }
    
}

