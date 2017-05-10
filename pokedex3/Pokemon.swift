//
//  Pokemon.swift
//  pokedex3
//
//  Created by Munene Kaumbutho on 2017-05-03.
//  Copyright © 2017 Munene Kaumbutho. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var nextEvolutionName: String {
        
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        
        return _nextEvolutionLevel
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
    
    var baseAttack: String {
        
        if _baseAttack == nil {
            _baseAttack = ""
        }
        
        return _baseAttack
    }
    
    var nextEvolutionText: String {
        
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        
        return _nextEvolutionTxt
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var pokemonURL: String {
        get {
            return _pokemonURL
        }
        set {
            _pokemonURL = newValue
        }
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        self.pokemonURL = "\(BASE_URL)\(URL_POKEMON)\(self._pokedexId!)/"
        
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(self.pokemonURL, method: .get).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let baseAttack = dict["attack"] as? Int {
                    self._baseAttack = "\(baseAttack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/ \(name.capitalized)"
                            }
                        }
                    }
                    
                    print(self._type)
                    
                } else {
                    self._type = ""
                }
                
                // in order to get the description:
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>] , descArray.count > 0 {
                    
                    if let url = descArray[0]["resource_uri"] {
                        let descURL = "\(BASE_URL)\(url)"
                        
                        Alamofire.request(descURL, method: .get).responseJSON { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description.replacingOccurrences(of: "POKMON", with: "POKEMON")
                                }
                            }
                            
                            completed()
                            
                        }
                    }
                    
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        // exclude going through the 'mega' dictionary:
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoId
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLevel = "\(lvl)"
                                }
                            }
                            
                        }
                        
                    }
                    
                }
        
                
            }
            
            // in order to indeicate that all info has been downloaded:
            completed()
            
        }
        
        
    }
}
