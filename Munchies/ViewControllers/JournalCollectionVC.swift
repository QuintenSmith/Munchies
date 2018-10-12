//
//  JournalCollectionVC.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

private let reuseIdentifier = "journalCell"

class JournalCollectionVC: UICollectionViewController {
    
    
    //MARK: - Properties
    var recipies: [Recipe] = {
        
        
        let recipe1 = Recipe(picture: UIImage(named: "images")!, recipeTitle: "Lasagna", rating: 3)
        let recipe2 = Recipe(picture: UIImage(named: "images")!, recipeTitle: "Pasta", rating: 5)
        let recipe3 = Recipe(picture: UIImage(named: "images")!, recipeTitle: "Pasta", rating: 4)
        let recipe4 = Recipe(picture: UIImage(named: "images")!, recipeTitle: "Pasta", rating: 3)
        let recipe5 = Recipe(picture: UIImage(named: "images")!, recipeTitle: "Pasta", rating: 4)
        let recipe6 = Recipe(picture: UIImage(named: "images")!, recipeTitle: "Pasta", rating: 1)
        let recipe7 = Recipe(picture: UIImage(named: "images")!, recipeTitle: "Pasta", rating: 4)
        let recipe8 = Recipe(picture: UIImage(named: "images")!, recipeTitle: "Pasta", rating: 2)
        var someMockRecipe : [Recipe] = [recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8]
        
        return someMockRecipe
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

 
        // Do any additional setup after loading the view.
    }

    
    
    
    
    
 
    // MARK: - Navigation

    func prepare(for segue: UIStoryboardSegue, sender: UICollectionViewCell) {
        if segue.identifier == "toDetailView" {
            let destinationVC = segue.destination as? JournalCollectionViewCell
            let cell = sender as! JournalCollectionViewCell
            guard let indexPath = self.collectionView.indexPath(for: cell) else {return}
            //let entry = recipies[indexPath.row]
            //set the destination
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
   

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return recipies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? JournalCollectionViewCell else {return UICollectionViewCell()}
        let recipe = recipies[indexPath.row]
        cell.cellData = recipe
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
