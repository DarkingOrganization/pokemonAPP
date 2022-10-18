//
//  ViewControllerDetalles.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 15/10/22.
//

import UIKit

class ViewControllerDetalles: UIViewController {
    
    var viewControllerPrincipal = ViewController ()
    
    var selectedPokemon: String = ""
    var selectedPokemonImage: UIImage?
    var selectedPokemonIconoElement: UIImage?
    var selectedPokemonTextElement: String?
    
    
    var statsString1: String? = nil
    var statsString2: String? = nil
    var statsString3: String? = nil
    var statsString4: String? = nil
    var statsString5: String? = nil
    var statsString6: String? = nil
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsButton.layer.cornerRadius = 15
        evolutionButton.layer.cornerRadius = 15
        movesButton.layer.cornerRadius = 15
        
        statsButton.backgroundColor = #colorLiteral(red: 0.3951376379, green: 0.6996766925, blue: 0.8580685258, alpha: 1)
        statsButton.setTitleColor(.white, for: .normal)
        
        viewControllerPrincipal.gradient.frame = view.bounds
        self.view.layer.insertSublayer(viewControllerPrincipal.gradient, at:0)
        
        loaditems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
        
        namePokemon.text = selectedPokemon
        BigImage.image = selectedPokemonImage
        elementLabel.text = selectedPokemonTextElement?.capitalized
        
        elementIcon.image = selectedPokemonIconoElement
        viewElement.layer.cornerRadius = 30
        elementIcon.backgroundColor = #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
        elementIcon.layer.cornerRadius = 20
        elementLabel.backgroundColor = #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
        elementIcon.backgroundColor = #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
        viewElement.backgroundColor =  #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)  //#colorLiteral()
        
        
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
        
        performSegue(withIdentifier: "segueStats", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueStats" {
            let destinationVCDetails = segue.destination as! DetailsViewController
            
            
            destinationVCDetails.selectedPokemon = self.selectedPokemon
            destinationVCDetails.selectedPokemonImage = self.selectedPokemonImage
            destinationVCDetails.selectedPokemonIconoElement = self.selectedPokemonIconoElement
            destinationVCDetails.selectedPokemonTextElement = self.selectedPokemonTextElement
            
            destinationVCDetails.stats1 = self.viewControllerPrincipal.stats1
            destinationVCDetails.stats2 = self.viewControllerPrincipal.stats2
            destinationVCDetails.stats3 = self.viewControllerPrincipal.stats3
            destinationVCDetails.stats4 = self.viewControllerPrincipal.stats4
            destinationVCDetails.stats5 = self.viewControllerPrincipal.stats5
            destinationVCDetails.stats6 = self.viewControllerPrincipal.stats6
            
            destinationVCDetails.statsString1 = self.statsString1
            destinationVCDetails.statsString2 = self.statsString2
            destinationVCDetails.statsString3 = self.statsString3
            destinationVCDetails.statsString4 = self.statsString4
            destinationVCDetails.statsString5 = self.statsString5
            destinationVCDetails.statsString6 = self.statsString6
            
            
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
        
        progressStat1.progress = Float(viewControllerPrincipal.stats1 ?? 0)
        progressStat2.progress = Float(viewControllerPrincipal.stats2 ?? 0)
        progressStat3.progress = Float(viewControllerPrincipal.stats3 ?? 0)
        progressStat4.progress = Float(viewControllerPrincipal.stats4 ?? 0)
        progressStat5.progress = Float(viewControllerPrincipal.stats5 ?? 0)
        progressStat6.progress = Float(viewControllerPrincipal.stats6 ?? 0)
        
        stat1.text = statsString1
        stat2.text = statsString2
        stat3.text = statsString3
        stat4.text = statsString4
        stat5.text = statsString5
        stat6.text = statsString6
        
    }
    
    
    @IBAction func closePush(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 82.0/255.0, green: 153.0/255.0, blue: 216.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 82.0/255.0, green: 153.0/255.0, blue: 216.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.1, 0.1]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
    
    
    
    
}
