//
//  ViewControllerDetalles.swift
//  PokemonApp
//
//  Created by Alejanro Cardenas on 15/10/22.
//

import UIKit

class ViewControllerDetalles: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        setGradientBackground()

        
    }
    
    @IBOutlet weak var BigImage: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    
    @IBOutlet weak var elementLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stat1: UILabel!
    @IBOutlet weak var stat2: UILabel!
    @IBOutlet weak var stat3: UILabel!
    @IBOutlet weak var stat4: UILabel!
    @IBOutlet weak var stat5: UILabel!
    @IBOutlet weak var stat6: UILabel!
    
    @IBOutlet weak var progressStat1: UIProgressView!
    @IBOutlet weak var progressStat2: UIProgressView!
    @IBOutlet weak var progressStat3: UIProgressView!
    @IBOutlet weak var progressStat4: UIProgressView!
    @IBOutlet weak var progressStat5: UIProgressView!
    @IBOutlet weak var progressStat6: UIProgressView!

    
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
