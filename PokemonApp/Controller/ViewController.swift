import UIKit
class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonTree: UIButton!
    
    @IBOutlet weak var constrainCentre: NSLayoutConstraint!
    
    @IBOutlet weak var elemento: UIImageView!
    
    @IBOutlet weak var elemento2: UIImageView?
    @IBOutlet weak var pokemonPop: UIButton!
    @IBOutlet weak var featuresTotal: UIImageView!
    @IBOutlet weak var vistaFeatures: UIView!
    @IBOutlet weak var namePokemonFeatures: UILabel!
    @IBOutlet weak var codigoPokemonFeatures: UILabel!
    
    @IBOutlet weak var buttonViewT: UIButton!
 
    private var pokemonManager = PokemonManager()
    private var pokemones: [PokemonModel]? = []
    var pokemonesFiltrados: [PokemonModel]? = []
    private var codigoImagenPokemon:String?
    private var elementoText: String?
    private var boolVar: Bool = false


    var stats: [Float]? = [0,1,2,3,4,5]
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    lazy var gradient: CAGradientLayer = {
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        pokemonManager.delegate = self
        
        tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        vistaFeatures.layer.cornerRadius = 10
        
        gradient.frame = view.bounds
        self.view.layer.insertSublayer(gradient, at:0)
  
        loadItems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        constrainCentre.constant = -500
        vistaFeatures.alpha = 0
        buttonViewT.alpha = 0
        
        
        buttonOne.setImage(UIImage(named: "pikachuicono"), for: .normal)
        buttonTwo.setImage(UIImage(named: "localizacion"), for: .normal)
        buttonTree.setImage(UIImage(named: "dulce"), for: .normal)
        
        tableView.layer.borderColor = UIColor.red.cgColor
        self.tableView.layer.borderWidth = 2
    }
 
    
    @IBAction func closeFeatures(_ sender: UIButton) {
        
        constrainCentre.constant = -400
        vistaFeatures.alpha = 0
        buttonViewT.alpha = 0
    }
    
    
    
    func loadItems() {
        for pokemon in 1...809 {
            pokemonManager.fetchPokemon(pokemonCode: String(pokemon))
        }
        tableView.reloadData()
    }
    

    
    
    //MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        boolVar = true
        
        constrainCentre.constant = 0
        vistaFeatures.alpha = 1
        
        let poke: [PokemonModel]?
        if pokemonesFiltrados?.count == 0 {
            poke = pokemones
        } else{
            poke = pokemonesFiltrados
        }
        
        if let indexPokemon = poke?[indexPath.row] {
            
            for stat in 1...6{
            stats![stat - 1] = Float(indexPokemon.stats[stat - 1])
            }
    
            let codeP = imagenPokemonF(imagen: Int(indexPokemon.pokemonID)!)
            self.codigoPokemonFeatures.text = "#\(String(codeP!))"
            
            elemento.image = UIImage(named: indexPokemon.tipoPokemon)
            
            if let imagen2 = indexPokemon.tipoPokemon2 {
                if let elemento = UIImage(named: imagen2) {
                    elemento2?.image = elemento
                }
            }
            
            elementoText = "\(indexPokemon.tipoPokemon)"
            
            if let imagenPokemon = Int(indexPokemon.pokemonID) {
                
                self.codigoImagenPokemon = imagenPokemonF(imagen: imagenPokemon)
                
                
                let imagen = (UIImage(named: self.codigoImagenPokemon!))
                pokemonPop.setImage(imagen, for: .normal)
                buttonOne.setImage(imagen, for: .normal)
                featuresTotal.image = UIImage(named: self.codigoImagenPokemon!)
                
                self.namePokemonFeatures.text = indexPokemon.pokemonName.capitalized
                
            }
        }
        if let element = pokemones?[indexPath.row].tipoPokemon{
            elemento.image = UIImage(named: element)
        }
        
        UIView.animate(withDuration: 0.1, animations: { self.view.layoutIfNeeded()})
        
        buttonViewT.alpha = 0.5
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
    
    //MARK: - preparacion View Controller Detalles
    @IBAction func imageButtonPress (_ sender: UIButton) {
        
        if  boolVar == true {
            performSegue(withIdentifier: "detalles", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewControllerDetalles
        
        if tableView.indexPathForSelectedRow != nil {
            if let namePoke = namePokemonFeatures.text, let imagenSegue = featuresTotal.image, let elementIcon = elemento.image {
                destinationVC.selectedPokemon = namePoke
                destinationVC.selectedPokemonImage = imagenSegue
                destinationVC.selectedPokemonIconoElement = elementIcon
                destinationVC.selectedPokemonTextElement = self.elementoText
            }

            if let stats = stats{
                
                for stat in 1...6{
                
                destinationVC.stats![stat - 1] = Float(stats[(stat - 1)] / 100)
                    
                    let intStats = (Int(stats[(stat - 1)]))
                destinationVC.statsString = [String(intStats)]

                }
                
            }
        }
    }
}

//MARK: - PokemonManagerDelegate


extension ViewController: PokemonManagerDelegate {
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel) {
        DispatchQueue.main.async {
            
            let pokemoncito: [PokemonModel] = [PokemonModel(pokemonName: pokemon.pokemonName, imageFront: pokemon.imageFront, pokemonID: pokemon.pokemonID, tipoPokemon: pokemon.tipoPokemon, abilityPokemon: pokemon.abilityPokemon, tipoPokemon2: pokemon.tipoPokemon2, stats: pokemon.stats)]//, tipoPokemon2: pokemon.tipoPokemon2
            self.pokemones?.append(contentsOf: pokemoncito)
            self.pokemonesFiltrados = self.pokemones
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


//Mark - Tableview Datasource Methods
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonesFiltrados?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! PokemonCell
        
        //if let item = pokemones?[indexPath.row]{
        cell.pokemonLabel?.text = pokemonesFiltrados?[indexPath.row].pokemonName.capitalized
        
        
        if let codePokemon = imagenPokemonF(imagen: Int((pokemonesFiltrados?[indexPath.row].pokemonID)!)!){
            cell.codigoPokemonLabel.text = "#\(String(codePokemon))"
        }
        
        
        if let imagenPokemon = Int((pokemonesFiltrados?[indexPath.row].pokemonID)!) {
            
            self.codigoImagenPokemon = imagenPokemonF(imagen: imagenPokemon)
            
            if let codigo = codigoImagenPokemon{
                cell.pokemonImage.image = UIImage(named: codigo)
                
                
            }
        }
        if let tipo = pokemonesFiltrados?[indexPath.row].tipoPokemon{ //, let tipo2 =  pokemones?[indexPath.row].tipoPokemon2
            cell.imageClaseOne.image = UIImage(named: tipo)
            
        }
        
        if let tipo2 = pokemonesFiltrados?[indexPath.row].tipoPokemon2{
            cell.imageClaseTwo.image = UIImage(named: tipo2)
        }
        
        return cell
    }
    
}


//MARK: - UISearch

//Mark: - Searchbar delegate methods

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonesFiltrados = []
        
        if searchText == "" {
            pokemonesFiltrados = pokemones
            
        } else {
            for pokemon in self.pokemones!{
                if pokemon.pokemonName.contains(searchText.lowercased()){
                    pokemonesFiltrados?.append(pokemon)
                }
                boolVar = false
                
            }
            //            pokemonesFiltrados = pokemones?.filter({$0.pokemonName == text})
            //                pokemonesFiltrados = pokemonFil
        }
        
        self.tableView.reloadData()
        
    }
}




