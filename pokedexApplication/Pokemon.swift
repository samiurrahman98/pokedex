//
//  Pokemon.swift
//  pokedexApplication
//
//  Created by Samiur Rahman on 2017-01-24.
//  Copyright © 2017 Samiur Rahman. All rights reserved.
//

import Foundation

class Pokemon
{
    private var _name: String!
    private var _pokedexID: Int!
    
    var name: String
        {
            return _name
    }
    
    var pokedexID: Int
        {
            return _pokedexID
    }
    
    init(name: String, pokedexID: Int)
    {
        self._name = name
        self._pokedexID = pokedexID
    }
}
