
import UIKit
class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UISearchBar!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonTree: UIButton!
   
    
  
    @IBOutlet weak var constrainCentre: NSLayoutConstraint!

    @IBOutlet weak var elemento: UIImageView!
    @IBOutlet weak var pokemonPop: UIImageView!
    @IBOutlet weak var featuresTotal: UIImageView!
    @IBOutlet weak var vistaFeatures: UIView!
    
   
    
    private var pokemonManager = PokemonManager()
    private var codigo: String = ""
    var pokemones: [PokemonModel]? = []
   
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
        var codigoImagenPokemon:String? = " "
        if let imagenPokemon = Int((pokemones?[indexPath.row].pokemonID)!) {
            if imagenPokemon < 10 {
                codigoImagenPokemon = "00\(imagenPokemon)"
            } else if imagenPokemon < 100 {
                codigoImagenPokemon = "0\(imagenPokemon)"
            } else if imagenPokemon < 810 {
                codigoImagenPokemon = "\(imagenPokemon)"
            } else {
                codigoImagenPokemon = nil
            }
            if let codigo = codigoImagenPokemon{
                pokemonPop.image = UIImage(named: codigo)
                featuresTotal.image = UIImage(named: codigo)
        }
    }
        if let element = pokemones?[indexPath.row].tipoPokemon{
        elemento.image = UIImage(named: element)
        }
        UIView.animate(withDuration: 0.1, animations: { self.view.layoutIfNeeded()})
            
    }
    @IBAction func closeFeatures(_ sender: UIButton) {
    
        constrainCentre.constant = -400
        vistaFeatures.alpha = 0
    }
    
    func loadItems() {
        
        
        for pokemon in 1...809 {
                pokemonManager.fetchPokemon(pokemonCode: String(pokemon))
            }
            tableView.reloadData()
        
    }
    
//MARK: - PokemonManagerDelegate
}

extension ViewController: PokemonManagerDelegate {
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel) {
        DispatchQueue.main.async {
   
            let pokemoncito: [PokemonModel] = [PokemonModel(pokemonName: pokemon.pokemonName, imageFront: pokemon.imageFront, pokemonID: pokemon.pokemonID, tipoPokemon: pokemon.tipoPokemon, tipoPokemon2: pokemon.tipoPokemon2)]
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
    
    var codigoImagenPokemon:String? = " "
    if let imagenPokemon = Int((pokemones?[indexPath.row].pokemonID)!) {
        if imagenPokemon < 10 {
            codigoImagenPokemon = "00\(imagenPokemon)"
        } else if imagenPokemon < 100 {
            codigoImagenPokemon = "0\(imagenPokemon)"
        } else if imagenPokemon < 810 {
            codigoImagenPokemon = "\(imagenPokemon)"
        } else {
            codigoImagenPokemon = nil
        }
        if let codigo = codigoImagenPokemon{
                cell.pokemonImage.image = UIImage(named: codigo)
                
        
    }
}
    if let tipo = pokemones?[indexPath.row].tipoPokemon, let tipo2 =  pokemones?[indexPath.row].tipoPokemon2{
    cell.imageClaseOne.image = UIImage(named: tipo)
        cell.imageClaseTwo.image = UIImage(named: tipo2)
    }
    return cell
}
}



