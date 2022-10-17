
import UIKit
class ViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {

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
    @IBOutlet weak var abilityFeatures: UILabel!
    
    @IBOutlet weak var buttonViewT: UIButton!
    
    
    private var pokemonManager = PokemonManager()
    private var pokemones: [PokemonModel]? = []
    private var pokemonesFiltrados: [PokemonModel]? = []
    private var codigoImagenPokemon:String?
    private var elementoText: String?
    private var boolVar: Bool = false
    var stats1: Float?
    var stats2: Float?
    var stats3: Float?
    var stats4: Float?
    var stats5: Float?
    var stats6: Float?
    
    private var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        tableView.dataSource = self
        tableView.delegate = self
        pokemonManager.delegate = self
    
        tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")

        let tittle = "Pokemon"
        title = tittle
        
        vistaFeatures.layer.cornerRadius = 10
        
        
        loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        constrainCentre.constant = -500
        vistaFeatures.alpha = 0
        buttonViewT.alpha = 0
        
        
        
        setGradientBackground()
            
            
        
        buttonOne.setImage(UIImage(named: "pikachuicono"), for: .normal)
        buttonTwo.setImage(UIImage(named: "localizacion"), for: .normal)
        buttonTree.setImage(UIImage(named: "dulce"), for: .normal)
        
    }
    
    
    
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

            if let stats1 = stats1, let stats2 = self.stats2, let stats3 = self.stats3, let stats4 = self.stats4, let stats5 = self.stats5, let stats6 = self.stats6{
        
            destinationVC.stats1 = Float(stats1 / 100)
            destinationVC.stats2 = Float(stats2 / 100)
            destinationVC.stats3 = Float(stats3 / 100)
            destinationVC.stats4 = Float(stats4 / 100)
            destinationVC.stats5 = Float(stats5 / 100)
            destinationVC.stats6 = Float(stats6 / 100)
                
                destinationVC.statsString1 = String(Int(stats1))
                destinationVC.statsString2 = String(Int(stats2))
                destinationVC.statsString3 = String(Int(stats3))
                destinationVC.statsString4 = String(Int(stats4))
                destinationVC.statsString5 = String(Int(stats5))
                destinationVC.statsString6 = String(Int(stats6))
            
    
        }
    }
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
        let colorTop =  UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 222.0/255.0, green: 245.0/255.0, blue: 219.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.1]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
    
//MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        boolVar = true
        constrainCentre.constant = 0
        vistaFeatures.alpha = 1
        
        if let statsPokemon1 = pokemones?[indexPath.row].stats1, let statsPokemon2 = pokemones?[indexPath.row].stats2, let statsPokemon3 = pokemones?[indexPath.row].stats3, let statsPokemon4 = pokemones?[indexPath.row].stats4, let statsPokemon5 = pokemones?[indexPath.row].stats5, let statsPokemon6 = pokemones?[indexPath.row].stats6     {
            
            self.stats1 = Float(statsPokemon1)
            self.stats2 = Float(statsPokemon2)
            self.stats3 = Float(statsPokemon3)
            self.stats4 = Float(statsPokemon4)
            self.stats5 = Float(statsPokemon5)
            self.stats6 = Float(statsPokemon6)
            
        }
 
        if let detailsPokemon = pokemones?[indexPath.row] {
            self.codigoPokemonFeatures.text = detailsPokemon.pokemonID
            
            
            elemento.image = UIImage(named: detailsPokemon.tipoPokemon)
            
            if let imagen2 = detailsPokemon.tipoPokemon2 {
            if let elemento = UIImage(named: imagen2) {
                elemento2?.image = elemento
            }
            }
           
            elementoText = "\(detailsPokemon.tipoPokemon)"
   
        if let imagenPokemon = Int(detailsPokemon.pokemonID) {
            self.codigoImagenPokemon = imagenPokemonF(imagen: imagenPokemon)
            
                
            let imagen = (UIImage(named: self.codigoImagenPokemon!))
                     pokemonPop.setImage(imagen, for: .normal)
                     buttonOne.setImage(imagen, for: .normal)
                     featuresTotal.image = UIImage(named: self.codigoImagenPokemon!)
            
            
            self.namePokemonFeatures.text = detailsPokemon.pokemonName.capitalized
            
        
             }
    }
        if let element = pokemones?[indexPath.row].tipoPokemon{
        elemento.image = UIImage(named: element)
        }

        UIView.animate(withDuration: 0.1, animations: { self.view.layoutIfNeeded()})
        
        buttonViewT.alpha = 0.5

        
    }


    
    
//MARK: - PokemonManagerDelegate
}

extension ViewController: PokemonManagerDelegate {
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel) {
        DispatchQueue.main.async {
   
            let pokemoncito: [PokemonModel] = [PokemonModel(pokemonName: pokemon.pokemonName, imageFront: pokemon.imageFront, pokemonID: pokemon.pokemonID, tipoPokemon: pokemon.tipoPokemon, abilityPokemon: pokemon.abilityPokemon, tipoPokemon2: pokemon.tipoPokemon2, stats1: pokemon.stats1, stats2: pokemon.stats2, stats3: pokemon.stats3, stats4: pokemon.stats4, stats5: pokemon.stats5, stats6: pokemon.stats6)]//, tipoPokemon2: pokemon.tipoPokemon2
            self.pokemones?.append(contentsOf: pokemoncito)
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
    if let codePokemon = Int((pokemonesFiltrados?[indexPath.row].pokemonID)!){
    cell.codigoPokemonLabel.text = "\(codePokemon)"
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

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        
        let pokemonFil: [PokemonModel]?
        pokemonesFiltrados = []
        guard let text = searchController.searchBar.text?.lowercased() else {
            return
        }
        
        if text == "" {
            pokemonesFiltrados = pokemones
        } else {
           
                pokemonFil = pokemones?.filter({$0.pokemonName == text})
                pokemonesFiltrados = pokemonFil
        }
        boolVar = false

        self.tableView.reloadData()
    }
    
    
}
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
////            pokemones? = pokemones?.filter("name CONTAINS[cd] %@", searchBar.text!)
//            pokemones? = (pokemones?.filter("title CONTAINS[cd] %@", searchBar.text!)
//            //toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
//            tableView.reloadData()
//        }
//
//        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            if searchBar.text?.count == 0 {
//               loadItems()
//                DispatchQueue.main.async {
//                    searchBar.resignFirstResponder()
//                }
//            }
//        }
        
     
            



 

