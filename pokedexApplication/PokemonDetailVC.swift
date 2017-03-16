//
//  PokemonDetailVC.swift
//  pokedexApplication
//
//  Created by Samiur Rahman on 2017-01-26.
//  Copyright © 2017 Samiur Rahman. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokedexID)")
        mainImage.image = img
        currentEvolutionImage.image = img
            
        pokemon.downloadPokemonDetails {
            () -> () in // called after download is complete
            self.updateUI()
        }
    }
    func updateUI() {
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        pokedexIDLabel.text = "\(pokemon.pokedexID)"
        weightLabel.text = pokemon.weight
        baseAttack.text = pokemon.attack
        
        if pokemon.nextEvolutionID == "" {
            evolutionLabel.text = "No Evolutions"
            nextEvolutionImage.isHidden = true
        } else {
            nextEvolutionImage.isHidden = false
            nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionID)
            var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            
            if pokemon.nextEvolutionLevel != "" {
                str += " - LVL \(pokemon.nextEvolutionLevel)"
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }

}
