//
//  Pokemon.swift
//  pokedexApplication
//
//  Created by Samiur Rahman on 2017-01-24.
//  Copyright © 2017 Samiur Rahman. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon
{
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var nextEvolutionLevel: String {
        get {
            if _nextEvolutionLevel == nil {
                _nextEvolutionLevel = ""
            }
            return _nextEvolutionLevel
        }
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var name: String {
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
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\((self._pokedexID)!)/"
        print()
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { response in
                if let dict = response.result.value as?  Dictionary<String, Any> {
                        if let weight = dict["weight"] as? String {
                            self._weight = weight
                        }
                        if let height = dict["height"] as? String {
                                self._height = height
                        }
                        if let attack = dict["attack"] as? Int {
                            self._attack = "\(attack)"
                        }
                        if let defense = dict["defense"] as? Int {
                            self._defense = "\(defense)"
                        }
                    
                        print(self._weight)
                        print(self._height)
                        print(self._attack)
                        print(self._defense)
                    
                    if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                        if let name = types[0]["name"] {
                            self._type = name.capitalized
                        }
                        
                        if types.count > 1 {
                            for i in 1..<types.count {
                                if let name = types[i]["name"] {
                                    self._type! += "/\(name.capitalized)"
                                }
                            }
                        } else {
                            
                        }
                        
                        print(self._type)
                        
                        if let descriptionArr = dict["descriptions"] as? [Dictionary<String, String>], descriptionArr.count > 0 {
                            if let url = descriptionArr[0]["resource_uri"] {
                                let anotherURL = "\(URL_BASE)\(url)"
                                Alamofire.request(anotherURL).responseJSON { response in
                                    let desResult = response.result
                                    if let descDict = desResult.value as?  Dictionary<String, Any> {
                                        if let description = descDict["description"] as? String {
                                            self._description = description
                                            print(self._description)
                                        }
                                    }
                                    completed()
                                }
                        } else {
                            self._description = ""
                        }
                            
                        if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                            if let to = evolutions[0]["to"] as? String {
                                //Mega evolutions not supported right now
                                if to.range(of: "mega") == nil {
                                    if let uri = evolutions[0]["resource_uri"] as? String {
                                        let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                            
                                        let num = newStr.replacingOccurrences(of: "/", with: "")
                                            
                                        self._nextEvolutionID = num
                                        self._nextEvolutionText = to
                                            
                                        if let level = evolutions[0]["level"] as? Int {
                                            self._nextEvolutionLevel = "\(level)"
                                        }
                                            
                                        print(self._nextEvolutionID)
                                        print(self._nextEvolutionText)
                                        if self._nextEvolutionLevel != nil {
                                                print(self._nextEvolutionLevel)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
