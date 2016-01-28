//
//  Pokemon.swift
//  Pokedex
//
//  Created by Brian Wilson on 1/23/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemanURL: String!
    private var _descriptionURL: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var weight: String {
        if _weight == nil {
         _weight = ""
        }
        return _weight  
    }
    
    var descript: String {
        if _description == nil {
             _description = ""
        }
        return _description
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        _pokemanURL = "\(POKE_URL)\(POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemanURL)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            do {
                let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = String(attack)
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = String(defense)
                }
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    for i in 0..<types.count {
                        if let curType = types[i]["name"] {
                            if i == 0 {
                                self._type = curType.capitalizedString
                            } else {
                                self._type! += "/\(curType.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = "N/A"
                }
                
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>] where descriptionArray.count > 0 {
                    if let uri = descriptionArray[0]["resource_uri"] {
                        self._descriptionURL = String(NSURL(string: "\(POKE_URL)\(uri)")!)
                    }
                }
                
                let url2 = NSURL(string: self._descriptionURL)!
                let task = session.dataTaskWithURL(url2) { (data, response, error) -> Void in
                    
                    do {
                        let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
                        
                        if let description = dict["description"] as? String! {
                            let newString1 = description.stringByReplacingOccurrencesOfString("POKMON", withString: "Pokémon", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            let newString2 = newString1.stringByReplacingOccurrencesOfString("Pokémons", withString: "Pokémon's", options: NSStringCompareOptions.LiteralSearch, range: nil)
                            self._description = newString2
                            completed()
                        }
                    }
                    catch {
                        print("json error: \(error)")
                    }
                }
                task.resume()
            }
            catch {
                print("json error: \(error)")
            }
        }
        task.resume()
    }
}



