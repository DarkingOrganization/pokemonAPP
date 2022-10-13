
import UIKit
class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UISearchBar!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonTree: UIButton!
   
    
  
    @IBOutlet weak var constrainCentre: NSLayoutConstraint!

    @IBOutlet weak var elemento: UIImageView!
    @IBOutlet weak var pokemonPop: UIButton!
    @IBOutlet weak var featuresTotal: UIImageView!
    @IBOutlet weak var vistaFeatures: UIView!
    @IBOutlet weak var namePokemonFeatures: UILabel!
    @IBOutlet weak var codigoPokemonFeatures: UILabel!
    @IBOutlet weak var abilityFeatures: UILabel!
    
    @IBOutlet weak var buttonViewT: UIButton!
    
    
    private var pokemonManager = PokemonManager()
    var pokemones: [PokemonModel]? = []
    private var codigoImagenPokemon:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
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
        constrainCentre.constant = -500
        vistaFeatures.alpha = 0
        buttonViewT.alpha = 0
        
    }
    
    @IBAction func imageButtonPress (_ sender: UIButton) {
        performSegue(withIdentifier: "detalles", sender: self)
        
        
    }
    
    
    //    func editSearchBar () {
//        if let pokemon = searchTextField.text {
//            pokemonManager.fetchPokemon(pokemonCode: pokemon)
//        }
//    }

    //Mark - TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        constrainCentre.constant = 0
        vistaFeatures.alpha = 1
     
 
        if let detailsPokemon = pokemones?[indexPath.row] {
            self.namePokemonFeatures.text = detailsPokemon.pokemonName
            self.codigoPokemonFeatures.text = detailsPokemon.pokemonID
            
         self.abilityFeatures.text = "Ability:\(detailsPokemon.abilityPokemon)"
            
            elemento.image = UIImage(named: detailsPokemon.tipoPokemon)
   
        if let imagenPokemon = Int(detailsPokemon.pokemonID) {
            self.codigoImagenPokemon = imagenPokemonF(imagen: imagenPokemon)
           
//            if let codigo = codigoImagenPokemon{
//                self.featuresTotal.image = UIImage(named: codigo)
                
            let imagen = (UIImage(named: self.codigoImagenPokemon!))
                     pokemonPop.setImage(imagen, for: .normal)
                     featuresTotal.image = UIImage(named: self.codigoImagenPokemon!)
             }
            
           // self.featuresTotal.image = UIImage(named: (pokemones?[indexPath.row].imageFront)!)
        
    }
        if let element = pokemones?[indexPath.row].tipoPokemon{
        elemento.image = UIImage(named: element)
        }
    
        
        UIView.animate(withDuration: 0.1, animations: { self.view.layoutIfNeeded()})
        
        buttonViewT.alpha = 0.5
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
    
//MARK: - PokemonManagerDelegate
}

extension ViewController: PokemonManagerDelegate {
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel) {
        DispatchQueue.main.async {
   
            let pokemoncito: [PokemonModel] = [PokemonModel(pokemonName: pokemon.pokemonName, imageFront: pokemon.imageFront, pokemonID: pokemon.pokemonID, tipoPokemon: pokemon.tipoPokemon, abilityPokemon: pokemon.abilityPokemon)]//, tipoPokemon2: pokemon.tipoPokemon2
            self.pokemones?.append(contentsOf: pokemoncito)
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

////Mark: - Searchbar delegate methods
//extension ViewController: UISearchBarDelegate{
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        //toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
//        tableView.reloadData()
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//           // loadItems()
//            DispatchQueue.main.async {
//                //searchBar.resignFirstResponder()
//            }
//        }
//    }
//}


//Mark - Tableview Datasource Methods
extension ViewController: UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pokemones?.count ?? 1
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! PokemonCell

    //if let item = pokemones?[indexPath.row]{
    cell.pokemonLabel?.text = pokemones?[indexPath.row].pokemonName
    cell.codigoPokemonLabel.text = pokemones?[indexPath.row].pokemonID
    

    
    if let imagenPokemon = Int((pokemones?[indexPath.row].pokemonID)!) {
        
        self.codigoImagenPokemon = imagenPokemonF(imagen: imagenPokemon)
        
        if let codigo = codigoImagenPokemon{
                cell.pokemonImage.image = UIImage(named: codigo)
                
        
    }
}
    if let tipo = pokemones?[indexPath.row].tipoPokemon{ //, let tipo2 =  pokemones?[indexPath.row].tipoPokemon2
    cell.imageClaseOne.image = UIImage(named: tipo)
        //cell.imageClaseTwo.image = UIImage(named: tipo2)
    }
    return cell
}
}



