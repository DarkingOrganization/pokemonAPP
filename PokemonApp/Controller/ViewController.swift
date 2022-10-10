
import UIKit
class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UISearchBar!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonTree: UIButton!
    private var pokemonManager = PokemonManager()
    var pokemones: [PokemonModel]? = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.dataSource = self
        tableView.delegate = self
        pokemonManager.delegate = self
        tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")

        let tittle = "Pokemon"
        title = tittle
        loadItems()
    }
    
//    func editSearchBar () {
//        if let pokemon = searchTextField.text {
//            pokemonManager.fetchPokemon(pokemonCode: pokemon)
//        }
//    }

    //Mark - TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "featuresSegue", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
    }

    func loadItems() {
            pokemonManager.fetchPokemon(pokemonCode: "1")
            pokemonManager.fetchPokemon(pokemonCode: "2")
            pokemonManager.fetchPokemon(pokemonCode: "3")
            pokemonManager.fetchPokemon(pokemonCode: "4")
            pokemonManager.fetchPokemon(pokemonCode: "5")
            pokemonManager.fetchPokemon(pokemonCode: "6")
            pokemonManager.fetchPokemon(pokemonCode: "7")
//            pokemones = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
            tableView.reloadData()
        
    }
    
//MARK: - PokemonManagerDelegate
}

extension ViewController: PokemonManagerDelegate {
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel) {
        DispatchQueue.main.async {
   
            let pokemoncito: [PokemonModel] = [PokemonModel(pokemonName: pokemon.pokemonName, imageFront: pokemon.imageFront, pokemonID: pokemon.pokemonID)]
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
    
    cell.pokemonImage.image = pokemones?[indexPath.row].imageFront
    

    
    return cell
    
    
}
}



