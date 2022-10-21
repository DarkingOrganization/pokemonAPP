import UIKit

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var codigoPokemonLabel: UILabel!
    @IBOutlet weak var imageClaseOne: UIImageView!
    @IBOutlet weak var imageClaseTwo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = UIColor.white
    }
}

