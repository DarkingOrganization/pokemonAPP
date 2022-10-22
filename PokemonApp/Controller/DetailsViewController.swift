import UIKit
class DetailsViewController: UIViewController {
    var viewControllerDetalles = ViewControllerDetalles ()
    var selectedPokemon: String = ""
    var selectedPokemonImage: UIImage?
    var selectedPokemonIconoElement: UIImage?
    var selectedPokemonTextElement: String?
    private var statsValues: [Float] = [0,1,2,3,4,5]
    var statsString: [String]? = ["1","2","3","4","5"]
    
    @IBOutlet weak private var statsViewD: StatsView!
    @IBOutlet private weak var titlePokemon: UILabel!
    @IBOutlet private weak var whiteBackground: UIImageView!
    @IBOutlet private weak var bigImage: UIImageView!
    
    @IBOutlet private weak var statsButton: UIButton!
    @IBOutlet private weak var evolutionButton: UIButton!
    @IBOutlet private weak var movesButton: UIButton!
    
    @IBAction private func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private var viewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitlePokemon()
        setupButtons()
        gradieteBackground()
        configWhiteImage()
        viewController.delegate = self
        viewController.updateDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statsViewD.loaditems(stats: statsValues)
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
        titlePokemon.text = selectedPokemon
        titlePokemon.textColor = .white
        bigImage.image = selectedPokemonImage
    }
    
    private func configStatsButton() {
        viewControllerDetalles.configStatsButton()
    }
    
    private func configEvolutionButton() {
        viewControllerDetalles.configEvolutionButton()
    }
    
    private func configMoveButton() {
        viewControllerDetalles.configMoveButton()
    }
    //MARK: - Gradiete
    private func gradieteBackground() {
        let gradient: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.type = .axial
            gradient.colors = [
                UIColor.init(named: "greenCustom")?.cgColor ?? "green",
                UIColor.init(named: "blueCustom")?.cgColor ?? "blue"
            ]
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            return gradient
        }()
        gradient.frame = view.bounds
        self.view.layer.insertSublayer(gradient, at:0)
    }
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
}

extension DetailsViewController: DatosPokemon {
    func datosPokemon(name: String, tipo: String, stats: [Float]?, codigoPokemon: String) {
        
        if let codigoImagenPokemon = viewController.renameImagenAssests(imagen: Int(codigoPokemon) ?? 001) {
            bigImage.image = UIImage(named: codigoImagenPokemon)
            
            if let valueStats = stats {
                updateStats(stats: valueStats)
            }
        }
    }
}
