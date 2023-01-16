import UIKit
import PodPokedex

class StatsController: UIViewController {
    
    private var gradietModel = GradieteModel()
    
    @IBOutlet weak private var whiteBackground: UIImageView!
    @IBOutlet weak private var bigImage: UIImageView!
    @IBOutlet weak private var namePokemon: UILabel!
    
    @IBOutlet weak private var elementLabel: UILabel!
    @IBOutlet weak private var elementIcon: UIImageView!
    @IBOutlet weak private var viewElement: UIView!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    @IBOutlet weak private var statsButton: UIButton!
    @IBOutlet weak private var evolutionButton: UIButton!
    @IBOutlet weak private var movesButton: UIButton!
    
    @IBOutlet weak private var statsView: StatsView!
    
    var pokemonSelect: PokemonModel? = nil
    
    private var detailsViewController = DetailsViewController()
    private var statsString: [String] = ["1", "2", "3", "4", "5"]
    private var statsValues: [Float] = [0,1,2,3,4,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupElement()
        loadPokemon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configWhiteImage()
        gradieteBackground()
        statsView.loaditems(stats: statsValues)
        loadPokemon()
    }
    
    @IBAction private func statsButtonPress(_ sender: UIButton) {
        configStatsButton()
        detailsViewController.pokemonSelect = self.pokemonSelect
        detailsViewController.statsValues = statsValues
        detailsViewController.imagenPokemon = bigImage.image
        detailsViewController.modalPresentationStyle = .overCurrentContext
        present(detailsViewController, animated: true, completion: nil)
    }
    
    @IBAction private func evolutionButtonPress(_ sender: UIButton) {
        configEvolutionButton()
    }
    
    @IBAction private func movesButtonPress(_ sender: UIButton) {
        configMoveButton()
    }
    
    private func setupButtons() {
        statsButton.layer.cornerRadius = 15
        evolutionButton.layer.cornerRadius = 15
        movesButton.layer.cornerRadius = 15
        statsButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.setTitleColor(.white, for: .normal)
    }
    
    private func setupElement() {
        viewElement.layer.cornerRadius = 30
        elementIcon.backgroundColor = #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
        elementIcon.layer.cornerRadius = 20
        elementLabel.backgroundColor = #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
        viewElement.backgroundColor =  #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
    }
    
    private func configWhiteImage() {
        whiteBackground.layer.cornerRadius = 50
        whiteBackground.backgroundColor = .white
    }
    
    private func configStatsButton() {
        statsButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.setTitleColor(.white, for: .normal)
        evolutionButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        evolutionButton.backgroundColor = .white
        movesButton.backgroundColor = .white
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
    }
    
    private func configEvolutionButton() {
        evolutionButton.setTitleColor(.white, for: .normal)
        evolutionButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.backgroundColor = .white
        movesButton.backgroundColor = .white
        statsButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
    }
    
    private func configMoveButton() {
        movesButton.setTitleColor(.white, for: .normal)
        movesButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.backgroundColor = .white
        evolutionButton.backgroundColor = .white
        statsButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        evolutionButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
    }
    //MARK: - CloseScreen
    @IBAction private func closePush(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }
    //MARK: - Gradiete
    private func gradieteBackground() {
        let gradient = gradietModel.gradient
        gradient.frame = view.bounds
        self.view.layer.insertSublayer(gradient, at:0)
    }
    //MARK: - LoadPokemon
    private func loadPokemon() {
        if let pokemon = pokemonSelect {
            for n in 1...statsValues.count {
                self.statsValues[n - 1] = Float(pokemon.stats[n - 1])
            }
            dataPokemon(name: pokemon.pokemonName, tipo: pokemon.tipoPokemon, stats: self.statsValues, codigoPokemon: pokemon.pokemonID)
        }
    }
    
    //MARK: - Protocol Stats
    private func calculatestats(_ stats: [Float]) {
        for stat in 1...stats.count {
            statsValues[stat - 1] = Float((stats[(stat - 1)]) / 100)
        }
    }
    
    private func updateStats(stats: [Float]) {
        DispatchQueue.main.async {
            self.calculatestats(stats)
        }
    }
    
    private func dataPokemon(name: String, tipo: String, stats: [Float]?, codigoPokemon: String) {
        let functionsPokemonSelect = FunctionsPokemonSelect(pokemonSelect?.pokemonID, [self.pokemonSelect])
        elementLabel.text = tipo
        elementIcon.image = UIImage(named: tipo)
        namePokemon.text = name.capitalized
        if let codigoImagenPokemon = functionsPokemonSelect.renameImagenAssets(imagen: Int(codigoPokemon) ?? 001) {
            bigImage.image = UIImage(named: codigoImagenPokemon)
            
            if let valueStats = stats {
                updateStats(stats: valueStats)
            }
        }
    }
}
