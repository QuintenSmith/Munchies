//
//  YouCanChangeThisLaterVCViewController.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class YouCanChangeThisLaterVCViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var recipies: [Recipe] = {
        
        let recipe1 = Recipe(picture: UIImage(named: "burger0")!, recipeTitle: "Burger", rating: 3)
        let recipe2 = Recipe(picture: UIImage(named: "pasta6")!, recipeTitle: "Pasta", rating: 5)
        let recipe3 = Recipe(picture: UIImage(named: "pizza1")!, recipeTitle: "Pizza", rating: 4)
        let recipe4 = Recipe(picture: UIImage(named: "salad2")!, recipeTitle: "Salad", rating: 3)
        let recipe5 = Recipe(picture: UIImage(named: "sandwich1")!, recipeTitle: "Sandwich", rating: 4)
        let recipe6 = Recipe(picture: UIImage(named: "burger2")!, recipeTitle: "Burger", rating: 1)
        let recipe7 = Recipe(picture: UIImage(named: "pizza3")!, recipeTitle: "Pizza", rating: 4)
        let recipe8 = Recipe(picture: UIImage(named: "salad6")!, recipeTitle: "Salad", rating: 2)
        var someMockRecipe : [Recipe] = [recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8]
        
        return someMockRecipe
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataSource = FavoritesCollectionViewDataSource(numberOfItems: 3, recepies: recipies)
        collectionView.dataSource = dataSource
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

}
