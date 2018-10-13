//
//  SearchVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
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
        
        self.searchCollectionView.delegate = self
        self.searchCollectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCollectionViewCell else {return UICollectionViewCell()}
        let recipe = recipies[indexPath.row]
        cell.cellData = recipe
        return cell
    }
}
