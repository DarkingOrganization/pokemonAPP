import UIKit

class StatsController: UIViewController, UniquePokemonData {
    
    var pokemonController = PokemonController()
    
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
    
    private var statsString: [String] = ["1", "2", "3", "4", "5"]
    private var statsValues: [Float] = [0,1,2,3,4,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonController.delegate = self
        pokemonController.updateDelegate()
        setupButtons()
        setupElement()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configWhiteImage()
        gradieteBackground()
        statsView.loaditems(stats: statsValues)   
    }
    
    @IBAction private func statsButtonPress(_ sender: UIButton) {
        configStatsButton()
        performSegue(withIdentifier: "segueStats", sender: self)
    }
    
    @IBAction private func evolutionButtonPress(_ sender: UIButton) {
        configEvolutionButton()
    }
    
    @IBAction private func movesButtonPress(_ sender: UIButton) {
        configMoveButton()
    }
    
    func setupButtons() {
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
    
    @IBAction private func closePush(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    //MARK: - Gradiete
    private func gradieteBackground() {
        let gradient = pokemonController.gradieteModel.gradient
        gradient.frame = view.bounds
        self.view.layer.insertSublayer(gradient, at:0)
    }
    //MARK: - Protocol Stats
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
        elementLabel.text = tipo
        elementIcon.image = UIImage(named: tipo)
        namePokemon.text = name
        if let codigoImagenPokemon = pokemonController.renameImagenAssests(imagen: Int(codigoPokemon) ?? 001) {
            bigImage.image = UIImage(named: codigoImagenPokemon)
            
            if let valueStats = stats {
                updateStats(stats: valueStats)
            }
        }
    }
}
