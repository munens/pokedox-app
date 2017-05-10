//
//  Constants.swift
//  pokedex3
//
//  Created by Munene Kaumbutho on 2017-05-09.
//  Copyright © 2017 Munene Kaumbutho. All rights reserved.
//

import Foundation

let BASE_URL = "http://pokeapi.co"
let URL_POKEMON = "/api/v1/pokemon/"

// set up a closure that is set called when the data that we need to load pokemon info is complete.

typealias DownloadComplete = () -> ()
