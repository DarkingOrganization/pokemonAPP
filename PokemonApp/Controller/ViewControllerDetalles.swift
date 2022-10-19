import UIKit

class ViewControllerDetalles: UIViewController {
    
    @IBOutlet weak var whiteBackground: UIImageView!
    @IBOutlet weak var BigImage: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    
    @IBOutlet weak var elementLabel: UILabel!
    @IBOutlet weak var elementIcon: UIImageView!
    @IBOutlet weak var viewElement: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stat1: UILabel!
    @IBOutlet weak var stat2: UILabel!
    @IBOutlet weak var stat3: UILabel!
    @IBOutlet weak var stat4: UILabel!
    @IBOutlet weak var stat5: UILabel!
    @IBOutlet weak var stat6: UILabel!
    
    @IBOutlet weak var LabelStats1: UILabel!
    @IBOutlet weak var LabelStats2: UILabel!
    @IBOutlet weak var LabelStats3: UILabel!
    @IBOutlet weak var LabelStats4: UILabel!
    @IBOutlet weak var LabelStats5: UILabel!
    @IBOutlet weak var LabelStats6: UILabel!
    
    @IBOutlet weak var progressStat1: UIProgressView!
    @IBOutlet weak var progressStat2: UIProgressView!
    @IBOutlet weak var progressStat3: UIProgressView!
    @IBOutlet weak var progressStat4: UIProgressView!
    @IBOutlet weak var progressStat5: UIProgressView!
    @IBOutlet weak var progressStat6: UIProgressView!
    
    
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var evolutionButton: UIButton!
    @IBOutlet weak var movesButton: UIButton!
    
    var selectedPokemon: String = ""
    var selectedPokemonImage: UIImage?
    var selectedPokemonIconoElement: UIImage?
    var selectedPokemonTextElement: String?
    
    var stats: [Float]? = [0,1,2,3,4,5]
    var statsString: [String] = ["1","2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        statsButton.layer.cornerRadius = 15
        evolutionButton.layer.cornerRadius = 15
        movesButton.layer.cornerRadius = 15
        
        statsButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.setTitleColor(.white, for: .normal)
        
        
        
        loaditems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        namePokemon.text = selectedPokemon
        BigImage.image = selectedPokemonImage
        elementLabel.text = selectedPokemonTextElement?.capitalized
        
        elementIcon.image = selectedPokemonIconoElement
        viewElement.layer.cornerRadius = 30
        elementIcon.backgroundColor = #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
        elementIcon.layer.cornerRadius = 20
        elementLabel.backgroundColor = #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
        viewElement.backgroundColor =  #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)  //#colorLiteral()
        
        whiteBackground.layer.cornerRadius = 50
        whiteBackground.backgroundColor = .white
        gradieteBackground()
    }
    
    @IBAction func statsButtonPress(_ sender: UIButton) {
        statsButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.setTitleColor(.white, for: .normal)
        evolutionButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        evolutionButton.backgroundColor = .white
        movesButton.backgroundColor = .white
        movesButton.setTitleColor(#colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1), for: .normal)
        
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
    
    @IBAction func closePush(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    //MARK: - Gradiete
    func gradieteBackground() {
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
}
