//
//  JournalDashboardVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/18/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalDashboardVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var recipes: [Recipe] = {
        
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
        let datasource = JournalCollectionViewDataSource(numberOfItems: 6, recipes: recipes)
        collectionView.dataSource = datasource
        NSLog("po %@", datasource)
        
        collectionView.reloadData()
        
    }
    
}
