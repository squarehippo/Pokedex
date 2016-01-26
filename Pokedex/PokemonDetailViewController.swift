//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Brian Wilson on 1/24/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionContent: UILabel!
    @IBOutlet weak var pokedexIdContent: UILabel!
    @IBOutlet weak var typeContent: UILabel!
    @IBOutlet weak var heightContent: UILabel!
    @IBOutlet weak var defenseContent: UILabel!
    @IBOutlet weak var weightContent: UILabel!
    @IBOutlet weak var baseAttackContent: UILabel!


    
    
    
    

    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        nameLabel.text = pokemon.name.capitalizedString
        mainImage.image = UIImage(named: String(pokemon.pokedexId))
        pokedexIdContent.text = String(pokemon.pokedexId)
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
            print(self.pokemon.weight)
        }

    }
    
    func updateUI() {
        weightContent.text = pokemon.weight
    }
}


