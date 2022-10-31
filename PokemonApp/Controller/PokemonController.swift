import UIKit

class PokemonController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak private var buttonOne: UIButton!
    @IBOutlet weak private var buttonTwo: UIButton!
    @IBOutlet weak private var buttonTree: UIButton!
    @IBOutlet weak private var searchBar: UISearchBar!
    
    private var borderColor: CGColor?
    private var pokemonManager = PokemonManager()
    private var pokemones: [PokemonModel]? = []
    private var pokemonesFiltrados: [PokemonModel]? = []
    private var codigoImagenPokemon:String?
    private var elementoText: String?
    private var activeButtonOne: Bool = false
    private var gradieteModel = GradieteModel()
    
    private var stats: [Float] = [0,1,2,3,4,5]
    private var gradient: CAGradientLayer?
    private let viewFeatures = ViewFeatures()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupDelegates()
        registerCells()
        gradieteBackground()
        loadPokemons()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableBorderColor()
        setupIconsButtons()
        activeButtonOne = false
    }
    //MARK: - Delegates
    private func setupDelegates() {
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        pokemonManager.delegate = self
    }
    //MARK: - Gradiete
    private func gradieteBackground() {
        let gradient = gradieteModel.gradient
        self.gradient = gradient
        gradient.frame = view.bounds
        self.view.layer.insertSublayer(gradient, at:0)
    }
    //MARK: - Load Pokemons
    private func loadPokemons() {
        for pokemon in 1...50 {
            pokemonManager.fetchPokemon(pokemonCode: String(pokemon))
        }
        tableView.reloadData()
    }
    //MARK: - PokemonCell
    private func registerCells() {
        tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    //MARK: - Table Border
    private func tableBorderColor() {
        tableView.layer.borderColor = UIColor.red.cgColor
        self.tableView.layer.borderWidth = 2
    }
    //MARK: - 3 Butons
    private func setupIconsButtons() {
        buttonOne.setImage(UIImage(named: "pikachuicono"), for: .normal)
        buttonTwo.setImage(UIImage(named: "localizacion"), for: .normal)
        buttonTree.setImage(UIImage(named: "dulce"), for: .normal)
    }
    //MARK: - PokemonFilter
    private func filterPokemon() -> [PokemonModel]? {
        if pokemonesFiltrados?.count == 0 {
            return pokemones
        } else {
            return pokemonesFiltrados
        }
    }
    //MARK: - preparacion View Controller
    @IBAction func imageButtonPress(_ sender: UIButton) {
        viewFeatures.modalPresentationStyle = .overFullScreen
        self.present(viewFeatures, animated: true)
        //  self.navigationController?.pushViewController(viewFeatures, animated: true)
    }
}
//MARK: - PokemonManagerDelegate
extension PokemonController: PokemonManagerDelegate {
    
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
extension PokemonController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonesFiltrados?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var functionsPokemonSelect = FunctionsPokemonSelect(codigoImagenPokemon, pokemonesFiltrados!)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! PokemonCell
        cell.pokemonLabel?.text = pokemonesFiltrados?[indexPath.row].pokemonName.capitalized
        if let codePokemon = functionsPokemonSelect.renameImagenAssets(imagen: Int((pokemonesFiltrados?[indexPath.row].pokemonID)!)!) {
            cell.codigoPokemonLabel.text = "#\(codePokemon)"
            
            functionsPokemonSelect.setupImagenPokemon(indexPath, cell)
            functionsPokemonSelect.setupImagenPokemon(indexPath, cell)
        }
        return cell
    }
}

//MARK: - TableViewDelegate Methods
extension PokemonController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activeButtonOne = true
        
        if let pokemonFiltrado = pokemonesFiltrados?[indexPath.row] {
            self.viewFeatures.pokemonSelect = pokemonFiltrado
            self.buttonOne.setImage(UIImage(named: pokemonFiltrado.pokemonID), for: .normal)
        }
        self.viewFeatures.modalPresentationStyle = .overCurrentContext
        self.present(viewFeatures, animated: true, completion: nil)
        //      self.navigationController?.pushViewController(viewFeatures, animated: true)
    }
}

//MARK: - Searchbar delegate methods
extension PokemonController: UISearchBarDelegate {
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
