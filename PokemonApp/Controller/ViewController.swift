import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak private var buttonOne: UIButton!
    @IBOutlet weak private var buttonTwo: UIButton!
    @IBOutlet weak private var buttonTree: UIButton!
    
    @IBOutlet weak private var constrainCentre: NSLayoutConstraint!
    
    @IBOutlet weak private var elemento: UIImageView!
    @IBOutlet weak private var elemento2: UIImageView?
    @IBOutlet weak private var pokemonPop: UIButton!
    @IBOutlet weak private var featuresTotal: UIImageView!
    @IBOutlet weak private var vistaFeatures: UIView!
    @IBOutlet weak private var namePokemonFeatures: UILabel!
    @IBOutlet weak private var codigoPokemonFeatures: UILabel!
    
    @IBOutlet weak private var buttonViewT: UIButton!
    
    private var pokemonManager = PokemonManager()
    private var pokemones: [PokemonModel]? = []
    private var pokemonesFiltrados: [PokemonModel]? = []
    private var codigoImagenPokemon:String?
    private var elementoText: String?
    private var activeButtonOne: Bool = false
    
    private var stats: [Float] = [0,1,2,3,4,5]
    @IBOutlet weak private var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupDelegates()
        gradieteBackground()
        loadItems()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        constrainsAndViewsConfig()
        tableBorderColor()
        setupIconsButtons()
    }
    
    @IBAction private func closeFeatures(_ sender: UIButton) {
        constrainCentre.constant = -500
        vistaFeatures.alpha = 0
        buttonViewT.alpha = 0
    }
    
    private func loadItems() {
        for pokemon in 1...809 {
            pokemonManager.fetchPokemon(pokemonCode: String(pokemon))
        }
        tableView.reloadData()
    }
    
    
    private func renameImagenAssests(imagen: Int) -> String? {
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
    //MARK: - Funciones didselect
    private func assignedStats(pokemonModel: [PokemonModel]?, indexPath: IndexPath, indexPokemon: PokemonModel) {
        if let countStats = pokemonModel?[indexPath.row].stats.count {
            
            for stat in 1...countStats {
                stats[stat - 1] = Float(indexPokemon.stats[stat - 1])
            }
        }
    }
    
    private func filterPokemon() -> [PokemonModel]? {
        if pokemonesFiltrados?.count == 0 {
            return pokemones
        } else {
            return pokemonesFiltrados
        }
    }
    
    private func showFeatureView() {
        constrainCentre.constant = 0
        vistaFeatures.alpha = 1
        UIView.animate(withDuration: 0.1, animations: { self.view.layoutIfNeeded()})
        buttonViewT.alpha = 0.5
    }
    
    private func setupCode(indexPokemon: PokemonModel) {
        let codeP = renameImagenAssests(imagen: Int(indexPokemon.pokemonID)!)
        self.codigoPokemonFeatures.text = "#\(String(codeP!))"
    }
    
    private func setupElement(indexPokemon: PokemonModel, indexPath: IndexPath) {
        elemento.image = UIImage(named: indexPokemon.tipoPokemon)
        elementoText = "\(indexPokemon.tipoPokemon)"
        
        if let imagen2 = indexPokemon.tipoPokemon2 {
            if let elemento = UIImage(named: imagen2) {
                elemento2?.image = elemento
            }
        }
        if let element = pokemones?[indexPath.row].tipoPokemon {
            elemento.image = UIImage(named: element)
        }
    }
    
    private func assignedImageAndName(indexPokemon: PokemonModel) {
        if let imagenPokemon = Int(indexPokemon.pokemonID) {
            self.codigoImagenPokemon = renameImagenAssests(imagen: imagenPokemon)
            
            let imagen = (UIImage(named: self.codigoImagenPokemon!))
            pokemonPop.setImage(imagen, for: .normal)
            buttonOne.setImage(imagen, for: .normal)
            featuresTotal.image = UIImage(named: self.codigoImagenPokemon!)
            self.namePokemonFeatures.text = indexPokemon.pokemonName.capitalized
        }
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
    
    private func setupDelegates() {
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        pokemonManager.delegate = self
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    private func constrainsAndViewsConfig() {
        vistaFeatures.layer.cornerRadius = 10
        constrainCentre.constant = -500
        vistaFeatures.alpha = 0
        buttonViewT.alpha = 0
    }
    private func setupIconsButtons() {
        buttonOne.setImage(UIImage(named: "pikachuicono"), for: .normal)
        buttonTwo.setImage(UIImage(named: "localizacion"), for: .normal)
        buttonTree.setImage(UIImage(named: "dulce"), for: .normal)
    }
    private func tableBorderColor() {
        tableView.layer.borderColor = UIColor.red.cgColor
        self.tableView.layer.borderWidth = 2
    }
    //MARK: - preparacion View Controller Detalles
    @IBAction func imageButtonPress(_ sender: UIButton) {
        
        if  activeButtonOne == true {
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
            
            for stat in 1...stats.count {
                
                destinationVC.stats?[stat - 1] = Float(stats[(stat - 1)] / 100)
                
                let intStats = (Int(stats[(stat - 1)]))
                destinationVC.statsString.append(String(intStats))
                
            }
        }
    }
}
//MARK: - PokemonManagerDelegate
extension ViewController: PokemonManagerDelegate {
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel) {
        DispatchQueue.main.async {
            let pokemoncito: [PokemonModel] = [PokemonModel(pokemonName: pokemon.pokemonName, imageFront: pokemon.imageFront, pokemonID: pokemon.pokemonID, tipoPokemon: pokemon.tipoPokemon, abilityPokemon: pokemon.abilityPokemon, tipoPokemon2: pokemon.tipoPokemon2, stats: pokemon.stats)]
            self.pokemones?.append(contentsOf: pokemoncito)
            self.pokemonesFiltrados = self.pokemones
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Tableview Datasource Methods
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonesFiltrados?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! PokemonCell
        cell.pokemonLabel?.text = pokemonesFiltrados?[indexPath.row].pokemonName.capitalized
        
        if let codePokemon = renameImagenAssests(imagen: Int((pokemonesFiltrados?[indexPath.row].pokemonID)!)!) {
            cell.codigoPokemonLabel.text = "#\(String(codePokemon))"
            setupTipoPokemon(indexPath, cell)
            setupImagenPokemon(indexPath, cell)
        }
        return cell
    }
    
    func setupTipoPokemon(_ indexPath: IndexPath,_ cell: PokemonCell) {
        if let tipo = pokemonesFiltrados?[indexPath.row].tipoPokemon {
            cell.imageClaseOne.image = UIImage(named: tipo)
            if let tipo2 = pokemonesFiltrados?[indexPath.row].tipoPokemon2 {
                cell.imageClaseTwo.image = UIImage(named: tipo2)
            }
        }
    }
    func setupImagenPokemon(_ indexPath: IndexPath,_ cell: PokemonCell) {
        if let imagenPokemon = Int((pokemonesFiltrados?[indexPath.row].pokemonID)!) {
            self.codigoImagenPokemon = renameImagenAssests(imagen: imagenPokemon)
            
            if let codigo = codigoImagenPokemon {
                cell.pokemonImage.image = UIImage(named: codigo)
            }
        }
    }
}
//MARK: - TableViewDelegate Methods
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activeButtonOne = true
        let pokemonSeleccionado = filterPokemon()
        
        showFeatureView()
        
        if let indexPokemon = pokemonSeleccionado?[indexPath.row] {
            assignedStats(pokemonModel: pokemonSeleccionado, indexPath: indexPath, indexPokemon: indexPokemon)
            setupCode(indexPokemon: indexPokemon)
            setupElement(indexPokemon: indexPokemon, indexPath: indexPath)
            assignedImageAndName(indexPokemon: indexPokemon)
        }
    }
}

//MARK: - Searchbar delegate methods
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonesFiltrados = []
        
        if searchText == "" {
            pokemonesFiltrados = pokemones
        } else {
            for pokemon in self.pokemones! {
                if pokemon.pokemonName.contains(searchText.lowercased()) {
                    pokemonesFiltrados?.append(pokemon)
                }
                activeButtonOne = false
            }
        }
        self.tableView.reloadData()
    }
}
