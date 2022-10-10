//
//  CaracteristicasViewCell.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 7/10/22.
//

import UIKit

class CaracteristicasViewCell: UITableViewCell {

    @IBOutlet weak var buttonPokemon: UIButton!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var codePokemon: UILabel!
    @IBOutlet weak var elementPokemon: UIImageView!
    @IBOutlet weak var featuresPokemon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
