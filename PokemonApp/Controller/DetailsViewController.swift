import UIKit
class DetailsViewController: UIViewController {
    var gradietModel = GradieteModel()
    
    var pokemonSelect: PokemonModel? = nil
    private var statsValues: [Float] = [0,1,2,3,4,5]
    private var statsString: [String]? = ["1","2","3","4","5"]
    
    @IBOutlet weak private var statsView: StatsView!
    @IBOutlet private weak var titlePokemon: UILabel!
    @IBOutlet private weak var whiteBackground: UIImageView!
    @IBOutlet private weak var bigImage: UIImageView!
    
    @IBOutlet private weak var statsButton: UIButton!
    @IBOutlet private weak var evolutionButton: UIButton!
    @IBOutlet private weak var movesButton: UIButton!
    
    @IBAction private func closeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitlePokemon()
        setupButtons()
        gradieteBackground()
        configWhiteImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statsView.loaditems(stats: statsValues)
    }
    
    @IBAction private func statsButtonPress(_ sender: UIButton) {
        configStatsButton()
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
    
    private func configWhiteImage() {
        whiteBackground.layer.cornerRadius = 50
        whiteBackground.backgroundColor = .white
    }
    
    private func setupTitlePokemon() {
        titlePokemon.text = pokemonSelect?.pokemonName
        titlePokemon.textColor = .white
        if let imagePokemon = pokemonSelect?.pokemonID {
        bigImage.image = UIImage(named: imagePokemon)
        }
    }
    
    func configStatsButton() {
        statsButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.setTitleColor(.white, for: .normal)
        evolutionButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        evolutionButton.backgroundColor = .white
        movesButton.backgroundColor = .white
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
    }
    
    func configEvolutionButton() {
        evolutionButton.setTitleColor(.white, for: .normal)
        evolutionButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.backgroundColor = .white
        movesButton.backgroundColor = .white
        statsButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
    }
    
    func configMoveButton() {
        movesButton.setTitleColor(.white, for: .normal)
        movesButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.backgroundColor = .white
        evolutionButton.backgroundColor = .white
        statsButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        evolutionButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
    }
    
    //MARK: - Gradiete
    func gradieteBackground() {
        let gradient = gradietModel.gradient
        gradient.frame = view.bounds
        self.view.layer.insertSublayer(gradient, at:0)
    }
    //MARK: - LoadPokemon
    func loadPokemon() {
        if let pokemon = pokemonSelect, let stats = pokemonSelect?.stats as! [Float]? {
        dataPokemon(name: pokemon.pokemonName, tipo: pokemon.tipoPokemon, stats: stats, codigoPokemon: pokemon.pokemonID)
        }
    }
    //MARK: - Stats
    func calculatestats (_ stats: [Float])  {
        for stat in 1...stats.count {
            statsValues[stat - 1] = Float((stats[(stat - 1)]) / 100)
        }
    }
    func updateStats(stats: [Float]) {
        DispatchQueue.main.async {
            self.calculatestats(stats)
        }
    }
    func dataPokemon(name: String, tipo: String, stats: [Float]?, codigoPokemon: String) {
        let functionsPokemonSelect = FunctionsPokemonSelect(codigoPokemon, [self.pokemonSelect])
        titlePokemon.text = name
        if let codigoImagenPokemon = functionsPokemonSelect.renameImagenAssets(imagen: Int(codigoPokemon) ?? 001) {
            bigImage.image = UIImage(named: codigoImagenPokemon)
            
            if let valueStats = stats {
                updateStats(stats: valueStats)
            }
        }
    }
}
