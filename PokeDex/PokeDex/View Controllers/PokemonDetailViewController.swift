//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Nichole Davidson on 3/13/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var searchPokemonBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeslabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
        // MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPokemonBar.delegate = self
        updateViews()

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        pokemonController?.pokemonSearch(searchTerm: searchTerm, completion: { error in
//            do {
//                let pokemonsListed = try searchTerm.get()
//            }
//        })
//    }
    private func updateViews() {
//        if pokemon != nil {
        guard let pokemon = pokemon else { return }
            title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(String(describing: pokemon.id))"
        abilitiesLabel.text = "\(pokemon.ability)"
//        } else {
//            self.title = "Pokemon Search"
        }
//        return
    
    
    @IBAction func savePokemonTapped(_ sender: Any) {
//        guard let name = nameLabel.text,
//            let id = idLabel.text,
//            let ability = abilitiesLabel.text,
//            let types = typeslabel.text,
//            name != ""  else { return }
            
        if let pokemon = pokemon {
            pokemonController?.pokemons.append(pokemon)
//            pokemonController?.addPokemon(withName: name, id: id, ability: ability, types: types)
        }
            self.navigationController?.popViewController(animated: true)
        }

}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController?.pokemonSearch(searchTerm: searchTerm, completion: { error in
            if let error = error {
                NSLog("Error in search: \(error)")
            } else {
                self.updateViews()
            }
        })
        
        pokemonController?.pokemonImage(at: pokemon?.image.url ?? "", completion: { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        })
    }
}
