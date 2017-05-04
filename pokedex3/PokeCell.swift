//
//  PokeCell.swift
//  pokedex3
//
//  Created by Munene Kaumbutho on 2017-05-04.
//  Copyright © 2017 Munene Kaumbutho. All rights reserved.
//

import Foundation
import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}

