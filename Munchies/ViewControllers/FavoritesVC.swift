//
//  FavoritesVC.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //MARK: - Outlets
    @IBOutlet weak var favloritesCollectionView: UICollectionView!
    
    
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
        
        favloritesCollectionView.delegate = self
        favloritesCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Colection View Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return recipies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? FavoritesCollectionViewCell else {return UICollectionViewCell()}
        let recipe = recipies[indexPath.row]
        cell.cellData = recipe
        return cell
    }
    
    
    
    
    //MARK: - Actions
    
    //TODO: - need to feed in the data for collection views based on which button was pressed
    
    @IBAction func wishListButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func sharedItemsButtonPressed(_ sender: Any) {
    }
    
    
    
    
    
}
