//
//  Pokemon.swift
//  pokedex3
//
//  Created by Munene Kaumbutho on 2017-05-03.
//  Copyright © 2017 Munene Kaumbutho. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: Strng!
    private var _pokedexId: Strng!
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: String {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = _pokedexId
    }
}
