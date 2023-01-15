import UIKit
import ApiPodPokedex

class ViewFeatures: UIViewController {
    
    @IBOutlet weak private var element2: UIImageView?
    @IBOutlet weak private var element: UIImageView!
    @IBOutlet weak private var smallImage: UIButton!
    @IBOutlet weak private var bigImage: UIImageView!
    
    @IBOutlet weak private var namePokemonFeatures: UILabel!
    @IBOutlet weak private var codigoImagenPokemon: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    private var statsController = StatsController()
    var pokemonSelect: PokemonModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.alpha = 0.5
        closeButton.backgroundColor = .white
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
    private func setupImagenPokemon() {
        let functionsPokemonSelect = FunctionsPokemonSelect(codigoImagenPokemon.text, [pokemonSelect])
        if let codigoImagenPokemon = functionsPokemonSelect.renameImagenAssets(imagen: Int(pokemonSelect!.pokemonID)!) {
            self.codigoImagenPokemon.text = "#\(codigoImagenPokemon)"
            bigImage.image = UIImage(named: codigoImagenPokemon)
            smallImage.setImage(UIImage(named: codigoImagenPokemon), for: .normal)
        }
    }
    private func setupNamePokemon() {
        if let namePokemon = pokemonSelect?.pokemonName {
            self.namePokemonFeatures.text = namePokemon.capitalized
        }
    }
//MARK: - Buttons Pressed
    @IBAction func closeButton(_ sender: Any) {
        // navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func smallImagePress(_ sender: UIButton) {
        self.statsController.pokemonSelect = pokemonSelect
        self.statsController.modalPresentationStyle = .overCurrentContext
        self.present(statsController, animated: true, completion: nil)
    }
}




