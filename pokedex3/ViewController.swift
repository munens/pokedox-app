//
//  ViewController.swift
//  pokedex3
//
//  Created by Munene Kaumbutho on 2017-05-03.
//  Copyright © 2017 Munene Kaumbutho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // tie the collection view to this class:
    
    @IBOutlet weak var collection: UICollectionView!
    
    // UICollectionViewDelegateFlowLayout creates the settings for the layout of the collection view.
    // UICollectionViewDataSource hodls the data for the collection view.
    // UICollectionViewDelegate sets this class as the delegate for the collection view.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collection.dataSource = self
        collection.delegate = self
    }
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // deqeueueReusableCell below recycles the cells that we see in the collection view: - we dont want to have to download all of them at once.
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon = Pokemon(name: "Pokemon", pokedexId: indexPath.row)
            cell.configureCell(pokemon)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    // function that runs when an item in the collection view is selected:
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // this next function returns the no of sections in the collection view:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    // find the no. of sections in our collection view:
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // sets the height of each collection view cell:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }

}

