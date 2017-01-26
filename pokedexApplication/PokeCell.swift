//
//  PokeCell.swift
//  pokedexApplication
//
//  Created by Samiur Rahman on 2017-01-24.
//  Copyright © 2017 Samiur Rahman. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell
{
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder:NSCoder)
    {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumbnailImage.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }
}
