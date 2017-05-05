//
//  ViewController.swift
//  pokedex3
//
//  Created by Munene Kaumbutho on 2017-05-03.
//  Copyright © 2017 Munene Kaumbutho. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // tie the collection view to this class:
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    // UICollectionViewDelegateFlowLayout creates the settings for the layout of the collection view.
    // UICollectionViewDataSource hodls the data for the collection view.
    // UICollectionViewDelegate sets this class as the delegate for the collection view.
    // UISearchBarDelegate sets this class as the delegate for the search bar.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        // change keyboard 'search' value to done:
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
    }
    
    
    // get the audo ready
    func initAudio() {
        // need to create a path to the music we brought in:
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            // get to  the audio playes
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)
                let name = row["identifier"]
                
                let poke = Pokemon(name: name!, pokedexId: pokeId!)
                
                pokemons.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // deqeueueReusableCell below recycles the cells that we see in the collection view: - we dont want to have to download all of them at once.
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke = pokemons[indexPath.row]
            cell.configureCell(poke)
            
            // if in search mode then load the filtered pokemon list/ else use the general pokemon list to use the degeueReusableCell:
            if inSearchMode {
                let poke = filteredPokemons[indexPath.row]
                cell.configureCell(poke)
            } else {
                let poke = pokemons[indexPath.row]
                cell.configureCell(poke)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    // function that runs when an item in the collection view is selected:
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // this next function returns the no of sections in the collection view:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemons.count
        }
        return pokemons.count
    }
    
    // find the no. of sections in our collection view:
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // sets the height of each collection view cell:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.2
            
        } else {
            
            musicPlayer.play()
            sender.alpha = 1.0
            
        }
    }
    
    // add a function that closes the software keyboard upon the 'cancel' button being clicked:
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // add a function that closes the software keyboard upon the 'cancel' button being clicked:
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    // function called when text is entered into the searchbar:
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            
            // repopulate the collection view with new data:
            collection.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            // make everything in the search bar lowercase:
            let lower = searchBar.text!.lowercased()
            
            // create a closure that filters the pokemons array according to whether the input in the search bar has words similar to any pokemon item names.
            // - '$0' is a placeholder for each of the pokemon items in the pokemon array.
            // - .range(.. ) checks whether there are any pokemon items that carry a name similar to our 'lower' variable previously defined that holds the value of whatever has been input into the search bar.
            filteredPokemons = pokemons.filter({$0.name.range(of: lower) != nil})
            
            // repoulate the collection view with new data:
            collection.reloadData()
        }
    }
}

