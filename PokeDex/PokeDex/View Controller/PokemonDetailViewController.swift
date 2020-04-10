//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

protocol PokemonSavedDelegate {
    func pokemonWasSaved(pokemon: Pokemon)
}

class PokemonDetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController = PokemonController()
    var pokemon: Pokemon!
    var delegate: PokemonSavedDelegate?
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self

    }
    
    private func searchWith(searchTerm: String) {
        pokemonController.searchForPokemon(searchTerm: searchTerm) {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    private func updateViews() {
        if pokemon != nil {
            guard let pokemon = pokemon else { return }
            title = pokemon.name
            pokemonNameLabel.text = pokemon.name
            pokemonImage.image = UIImage(imageLiteralResourceName: pokemon.sprites?.frontDefault ?? "") ////// not sure if this will work
            idLabel.text = "ID: \(String(describing: pokemon.id))"
            typesLabel.text = "Types: \(String(describing: pokemon.types))"
            abilitiesLabel?.text = "Abilities: \(String(describing: pokemon.abilities))"
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let name = pokemonNameLabel.text
        let pokemon = Pokemon(name: name)
        
        delegate?.pokemonWasSaved(pokemon: pokemon)
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        searchWith(searchTerm: searchTerm)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            updateViews()
            return
        }
        
        searchWith(searchTerm: searchText)
    }
}