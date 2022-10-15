//
//  ViewControllerDetalles.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 15/10/22.
//

import UIKit

class ViewControllerDetalles: UIViewController {
  
    var selectedPokemon: String = ""
    var selectedPokemonImage: UIImage?
    var selectedPokemonIconoElement: UIImage?
    var selectedPokemonTextElement: String?

    var stats1: Float?
    var stats2: Float?
    var stats3: Float?
    var stats4: Float?
    var stats5: Float?
    var stats6: Float?
    
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

    @IBOutlet weak var progressTest: UIProgressView!
    @IBOutlet weak var progressSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loaditems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
        
        namePokemon.text = selectedPokemon
        BigImage.image = selectedPokemonImage
        elementLabel.text = selectedPokemonTextElement?.capitalized
        
        elementIcon.image = selectedPokemonIconoElement
        viewElement.layer.cornerRadius = 10
        elementIcon.backgroundColor = #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
        elementLabel.backgroundColor = #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
        elementIcon.backgroundColor = #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)
        viewElement.backgroundColor =  #colorLiteral(red: 0.3221421838, green: 0.6007931232, blue: 0.8479036689, alpha: 1)  //#colorLiteral()
        whiteBackground.layer.cornerRadius = 50
        whiteBackground.backgroundColor = .white
        
        
        stat1.text = statsString1
        stat2.text = statsString2
        stat3.text = statsString3
        stat4.text = statsString4
        stat5.text = statsString5
        stat6.text = statsString6

    }
    
    func loaditems() {
        LabelStats1.text = "hp"
        LabelStats2.text = "Attack"
        LabelStats3.text = "Defense"
        LabelStats4.text = "Sp. Atk"
        LabelStats5.text = "Sp. Def"
        LabelStats6.text = "Speed"
        
        
        progressStat1.progress = Float(stats1 ?? 0)
        progressStat2.progress = Float(stats2 ?? 0)
        progressStat3.progress = Float(stats3 ?? 0)
        progressStat4.progress = Float(stats4 ?? 0)
        progressStat5.progress = Float(stats5 ?? 0)
        progressStat6.progress = Float(stats6 ?? 0)
        
      
        
    }
    
    
    @IBAction func closePush(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    
    func imagenPokemonF (imagen: Int) -> String? {
            if imagen < 10 {
                return "00\(String(imagen))"
            } else if imagen < 100 {
                return "0\(String(imagen))"
            } else if imagen < 810 {
                return "\(String(imagen))"
            } else {
                 return "nil"
            }
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
