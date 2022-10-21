import UIKit

class ViewControllerDetalles: UIViewController {
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
    
    var selectedPokemon: String = ""
    var selectedPokemonImage: UIImage?
    var selectedPokemonIconoElement: UIImage?
    var selectedPokemonTextElement: String?
    var stats: [Float]? = [0,0,0,0,0,0]
    var statsString: [String] = ["1","2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        loaditems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        namePokemon.text = selectedPokemon
        bigImage.image = selectedPokemonImage
        setupElement()
        configWhiteImage()
        gradieteBackground()
    }
    
    @IBAction private func statsButtonPress(_ sender: UIButton) {
        configStatsButton()
        performSegue(withIdentifier: "segueStats", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueStats" {
            let destinationVCDetails = segue.destination as! DetailsViewController
            
            destinationVCDetails.selectedPokemon = self.selectedPokemon
            destinationVCDetails.selectedPokemonImage = self.selectedPokemonImage
            destinationVCDetails.selectedPokemonIconoElement = self.selectedPokemonIconoElement
            destinationVCDetails.selectedPokemonTextElement = self.selectedPokemonTextElement
            destinationVCDetails.stats = stats
        }
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
        elementLabel.text = selectedPokemonTextElement?.capitalized
        elementIcon.image = selectedPokemonIconoElement
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
    
    @IBAction private func closePush(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
    
    private func loaditems() {
        if let stats = self.stats {
        statsView.loaditems(stats: stats)
        }
    }
}
