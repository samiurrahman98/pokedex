//
//  ViewController.swift
//  pokedexApplication
//
//  Created by Samiur Rahman on 2017-01-24.
//  Copyright © 2017 Samiur Rahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
        parsePokemonCSV()
    }
    
    func parsePokemonCSV()
    {
        let bundle = Bundle.main
        let path = bundle.path(forResource: "pokemon", ofType: "csv")!
        
        do
        {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
           
            for row in rows
            {
                if let pokeId = Int(row["id"]!), let name = row["identifier"]
                {
                    let poke = Pokemon(name: name, pokedexID: pokeId)
                    pokemon.append(poke)
                }
            }
            
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell
        {
            
            let poke = pokemon[indexPath.row]
            
            cell.configureCell(pokemon: poke)
            
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 718
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 105, height: 105)
    }
    
}

