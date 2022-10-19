import UIKit

class DetailsViewController: UIViewController {
    private var viewControllerPrincipal = ViewController ()
    var selectedPokemon: String = ""
    var selectedPokemonImage: UIImage?
    var selectedPokemonIconoElement: UIImage?
    var selectedPokemonTextElement: String?
    
    var stats: [Float]? = []
    var statsString: [String]? = ["1","2","3","4","cinco"]
    
    
    @IBOutlet private weak var titlePokemon: UILabel!
    
    @IBOutlet private weak var whiteBackground: UIImageView!
    @IBOutlet private weak var bigImage: UIImageView!
    
    @IBOutlet private weak var stat1: UILabel!
    @IBOutlet private weak var stat2: UILabel!
    @IBOutlet private weak var stat3: UILabel!
    @IBOutlet private weak var stat4: UILabel!
    @IBOutlet private weak var stat5: UILabel!
    @IBOutlet private weak var stat6: UILabel!
    
    @IBOutlet private weak var LabelStats1: UILabel!
    @IBOutlet private weak var LabelStats2: UILabel!
    @IBOutlet private weak var LabelStats3: UILabel!
    @IBOutlet private weak var LabelStats4: UILabel!
    @IBOutlet private weak var LabelStats5: UILabel!
    @IBOutlet private weak var LabelStats6: UILabel!
    
    @IBOutlet private weak var progressStat1: UIProgressView!
    @IBOutlet private weak var progressStat2: UIProgressView!
    @IBOutlet private weak var progressStat3: UIProgressView!
    @IBOutlet private weak var progressStat4: UIProgressView!
    @IBOutlet private weak var progressStat5: UIProgressView!
    @IBOutlet private weak var progressStat6: UIProgressView!
    
    
    @IBOutlet private weak var statsButton: UIButton!
    @IBOutlet private weak var evolutionButton: UIButton!
    @IBOutlet private weak var movesButton: UIButton!
    
    @IBAction private func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
      
    override func viewDidLoad() {
        super.viewDidLoad()
        titlePokemon.text = selectedPokemon
        titlePokemon.textColor = .white
        
        loaditems()
        
        statsButton.layer.cornerRadius = 15
        evolutionButton.layer.cornerRadius = 15
        movesButton.layer.cornerRadius = 15
        
        statsButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.setTitleColor(.white, for: .normal)
        
       gradieteBackground ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bigImage.image = selectedPokemonImage
        whiteBackground.layer.cornerRadius = 50
        whiteBackground.backgroundColor = .white
    }
    
    
    @IBAction func statsButtonPress(_ sender: UIButton) {
        statsButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.setTitleColor(.white, for: .normal)
        evolutionButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        evolutionButton.backgroundColor = .white
        movesButton.backgroundColor = .white
        evolutionButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
    }
    
    
    @IBAction func evolutionButtonPress(_ sender: UIButton) {
        evolutionButton.setTitleColor(.white, for: .normal)
        evolutionButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.backgroundColor = .white
        movesButton.backgroundColor = .white
        statsButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
    }
    
    @IBAction func movesButtonPress(_ sender: UIButton) {
        movesButton.setTitleColor(.white, for: .normal)
        movesButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.backgroundColor = .white
        evolutionButton.backgroundColor = .white
        statsButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        evolutionButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
    }
    
    
    func loaditems() {
        LabelStats1.text = "Hp"
        LabelStats2.text = "Attack"
        LabelStats3.text = "Defense"
        LabelStats4.text = "Sp. Atk"
        LabelStats5.text = "Sp. Def"
        LabelStats6.text = "Speed"
        
        if let stats = stats {
            progressStat1.progress = Float(stats[0])
            progressStat2.progress = Float(stats[1])
            progressStat3.progress = Float(stats[2])
            progressStat4.progress = Float(stats[3])
            progressStat5.progress = Float(stats[4])
            progressStat6.progress = Float(stats[5])
            
            
            stat1.text = String(Int(stats[0] * 100))
            stat2.text = String(Int(stats[1] * 100))
            stat3.text = String(Int(stats[2] * 100))
            stat4.text = String(Int(stats[3] * 100))
            stat5.text = String(Int(stats[4] * 100))
            stat6.text = String(Int(stats[5] * 100))
        }
    }
    //MARK: - Gradiete
    func gradieteBackground () {
        let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.init(named: "blueCustom")!.cgColor,
            UIColor.init(named: "greenCustom")!.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
        
        gradient.frame = view.bounds
        self.view.layer.insertSublayer(gradient, at:0)
        
    }
}
